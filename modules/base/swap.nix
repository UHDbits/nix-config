{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.swap;
in
{
  options.swap = {
    enable = mkEnableOption "the dedicated Btrfs swapfile";
    fileSizeMiB = mkOption {
      type = types.ints.positive;
      default = 8192;
      description = "Swapfile size in MiB.";
    };
    mode = mkOption {
      type = types.enum [
        "file"
        "zram+file"
        "zswap+file"
      ];
      default = "file";
      description = "Use ordinary disk swap, zswap-backed disk swap, or zram in front of disk swap.";
    };
    zramSizeMiB = mkOption {
      type = types.ints.unsigned;
      default = 0;
      description = "Logical zram capacity in MiB.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.mode != "zram+file" || cfg.zramSizeMiB > 0;
        message = "swap.zramSizeMiB must be positive with zram+file.";
      }
    ];

    swapDevices = [
      {
        device = "/.swap/swapfile";
        priority = 0;
        size = cfg.fileSizeMiB;
      }
    ];

    zramSwap = {
      algorithm = "zstd";
      enable = cfg.mode == "zram+file";
      memoryMax = cfg.zramSizeMiB * 1024 * 1024;
      memoryPercent = 100;
      priority = 5;
    };

    boot.kernelParams =
      if cfg.mode == "zswap+file" then
        [
          "zswap.compressor=zstd"
          "zswap.enabled=1"
          "zswap.max_pool_percent=10"
        ]
      else
        [
          "zswap.enabled=0"
        ];
  };
}
