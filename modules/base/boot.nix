{ config, lib, ... }:
let
  cfg = config.secureBoot;
in
{
  options.secureBoot.enable = lib.mkEnableOption "Limine Secure Boot";

  config = lib.mkMerge [
    {
      boot = {
        bcache.enable = false;
        initrd.verbose = false;
        consoleLogLevel = 3;
        kernelParams = [
          "quiet"
          "splash"
          "udev.log_level=3"
        ];
        loader = {
          efi.canTouchEfiVariables = true;
          limine = {
            efiSupport = true;
            enable = true;
            enableEditor = false;
            maxGenerations = 5;
            secureBoot.enable = cfg.enable;
            style.wallpapers = [ ../../assets/wallpaper.jpg ];
          };
          systemd-boot.enable = false;
          timeout = lib.mkDefault 10;
        };
        plymouth = {
          enable = true;
          theme = "bgrt";
        };
      };
    }
    (lib.mkIf cfg.enable {
      environment.persistence."/persist".directories = [ "/var/lib/sbctl" ];
    })
  ];
}
