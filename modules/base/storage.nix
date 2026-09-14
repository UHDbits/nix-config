{
  config,
  lib,
  pkgs,
  utils,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    optional
    optionals
    types
    ;
  btrfsDevice = if luksEnabled then "/dev/mapper/${cfg.luks.name}" else cfg.device;
  btrfsDeviceUnit = "${utils.escapeSystemdPath btrfsDevice}.device";
  btrfsOptions = subvolume: [
    "compress=zstd"
    "noatime"
    "subvol=${subvolume}"
  ];
  cfg = config.storage;
  cryptsetupUnit = "systemd-cryptsetup@${utils.escapeSystemdPath cfg.luks.name}.service";
  luksEnabled = cfg.luks.mode != "none";
in
{
  options.storage = {
    bootDevice = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "/dev/disk/by-partuuid/replace-me";
      description = "EFI system partition.";
    };
    device = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "/dev/disk/by-partuuid/replace-me";
      description = "Btrfs device, or the LUKS2 container when encryption is enabled.";
    };
    enable = mkEnableOption "the manually-created Btrfs storage layout";
    impermanence.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Replace the root subvolume on boot.";
    };
    luks = {
      allowDiscards = mkOption {
        type = types.bool;
        default = true;
        description = "Pass Btrfs TRIM requests through dm-crypt to the SSD.";
      };
      mode = mkOption {
        type = types.enum [
          "none"
          "passphrase"
          "tpm2-pin"
        ];
        default = "none";
        description = "LUKS2 unlock method; TPM2+PIN mode requires Secure Boot and still permits passphrase fallback.";
      };
      name = mkOption {
        type = types.str;
        default = "cryptroot";
        description = "dm-crypt mapping name.";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.device != null && cfg.bootDevice != null;
        message = "storage.device and storage.bootDevice must name the manually-created GPT partitions.";
      }
      {
        assertion = builtins.match "[A-Za-z0-9_-]+" cfg.luks.name != null;
        message = "storage.luks.name may contain only letters, digits, underscores, and hyphens.";
      }
      {
        assertion = cfg.luks.mode != "tpm2-pin" || config.secureBoot.enable;
        message = "storage.luks.mode = \"tpm2-pin\" requires secureBoot.enable = true.";
      }
    ];

    boot = {
      initrd = {
        luks.devices = mkIf luksEnabled {
          "${cfg.luks.name}" = {
            allowDiscards = cfg.luks.allowDiscards;
            crypttabExtraOpts = optionals (cfg.luks.mode == "tpm2-pin") [
              "tpm2-device=auto"
              "tpm2-pin=yes"
            ];
            device = cfg.device;
          };
        };
        supportedFilesystems = [ "btrfs" ];
        systemd.enable = true;
        systemd.initrdBin = [
          pkgs.btrfs-progs
          pkgs.coreutils
          pkgs.util-linux.mount
        ];
        systemd.tpm2.enable = cfg.luks.mode == "tpm2-pin";
      };
    };

    fileSystems = {
      "/" = {
        device = btrfsDevice;
        fsType = "btrfs";
        options = btrfsOptions "root";
      };
      "/.swap" = {
        device = btrfsDevice;
        fsType = "btrfs";
        options = [
          "noatime"
          "subvol=swap"
        ];
      };
      "/boot" = {
        device = cfg.bootDevice;
        fsType = "vfat";
        options = [ "umask=0077" ];
      };
      "/home" = {
        device = btrfsDevice;
        fsType = "btrfs";
        options = btrfsOptions "home";
      };
      "/nix" = {
        device = btrfsDevice;
        fsType = "btrfs";
        neededForBoot = true;
        options = btrfsOptions "nix";
      };
      "/persist" = {
        device = btrfsDevice;
        fsType = "btrfs";
        neededForBoot = true;
        options = btrfsOptions "persist";
      };
    };

    environment.persistence."/persist" = {
      directories = [
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/var/log"
      ];
      enable = true;
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
      ];
      hideMounts = true;
    };

    systemd.tmpfiles.rules = [ "d /persist/secrets 0700 root root -" ];
    services.btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };

    systemd.sleep.settings.Sleep = {
      AllowHibernation = false;
      AllowHybridSleep = false;
      AllowSuspendThenHibernate = false;
    };

    boot.initrd.systemd.services.root-rotation = mkIf cfg.impermanence.enable {
      after = [ btrfsDeviceUnit ] ++ optional luksEnabled cryptsetupUnit;
      before = [ "sysroot.mount" ];
      description = "Replace the root Btrfs subvolume";
      environment = {
        ROOT_ROTATION_DEVICE = btrfsDevice;
      };
      requiredBy = [ "sysroot.mount" ];
      requires = [ btrfsDeviceUnit ] ++ optional luksEnabled cryptsetupUnit;
      script = ''
        # Replace the root Btrfs subvolume before it is mounted.
        set -euo pipefail

        device=''${ROOT_ROTATION_DEVICE:?ROOT_ROTATION_DEVICE is required}
        mount_dir=''${ROOT_ROTATION_MOUNT:-/run/root-rotation}
        work_dir=''${ROOT_ROTATION_WORK_DIR:-"$mount_dir.work"}

        die() {
          echo "root-rotation: $*" >&2
          exit 1
        }

        if [ -r /proc/cmdline ]; then
          cmdline=$(cat /proc/cmdline)
          case " $cmdline " in
            *' root-rotation=skip '*)
              echo 'root-rotation: skipped for this boot'
              exit 0
              ;;
          esac
        fi

        mounted=0
        cleanup() {
          [ "$mounted" -eq 0 ] || umount "$mount_dir" || true
          rm -f "$work_dir/delete-list" "$work_dir/delete-list.sorted" 2>/dev/null || true
          rmdir "$work_dir" 2>/dev/null || true
          rmdir "$mount_dir" 2>/dev/null || true
        }
        trap cleanup EXIT

        mkdir -p "$mount_dir"
        mkdir "$work_dir"
        mount -o subvolid=5 "$device" "$mount_dir"
        mounted=1
        top=$mount_dir
        root=$top/root

        # The prefix check must never allow deletion outside root.
        list_descendants() {
          local target=$1 prefix=$2 line relative
          btrfs subvolume list -o "$target" |
            while IFS= read -r line; do
              case "$line" in
                *" path "*) relative=''${line##* path } ;;
                *) die "unrecognised btrfs subvolume output" ;;
              esac
              case "$relative" in
                "$prefix"/*) printf '%s\n' "$relative" ;;
                *) die "refusing descendant outside $prefix: $relative" ;;
              esac
            done
        }

        delete_tree() {
          local target=$1 prefix=$2 list relative
          list=$work_dir/delete-list
          list_descendants "$target" "$prefix" >"$list"
          btrfs property set "$target" ro false
          sort "$list" | while IFS= read -r relative; do
            [ -n "$relative" ] || continue
            btrfs property set "$top/$relative" ro false
          done
          sort -r "$list" >"$list.sorted"
          while IFS= read -r relative; do
            [ -n "$relative" ] || continue
            btrfs subvolume delete "$top/$relative"
          done <"$list.sorted"
          btrfs subvolume delete "$target"
          rm -f "$list" "$list.sorted"
        }

        btrfs subvolume show "$root" >/dev/null || die 'root must be a Btrfs subvolume'
        delete_tree "$root" root
        btrfs subvolume create "$root"
      '';
      serviceConfig.Type = "oneshot";
      unitConfig.DefaultDependencies = "no";
    };
  };
}
