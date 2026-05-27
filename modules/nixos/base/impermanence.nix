{ lib, ... }:
let
  clearScript = ''
    # Mount btrfs subvolume
    mkdir -p /btrfs_tmp
    mount -o subvol=/ -t btrfs /dev/disk/by-label/NixOS /btrfs_tmp

    delete_subvolume_recursively() {
      IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
    }

    # Delete old root subvolume recursively if it exists
    if [ -e /btrfs_tmp/root ]; then
        delete_subvolume_recursively /btrfs_tmp/root
    fi

    # Create new subvolume
    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
in
{
  environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;
        allowTrash = true;
        directories = [
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/cups"
          "/var/lib/boltd"
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/var/lib/fprint"
          "/var/lib/NetworkManager"
          "/var/lib/iwd"
          "/var/lib/tailscale"
          "/var/lib/libvirt"
          "/var/lib/docker"
          "/var/lib/sbctl"
          "/var/cache/libvirt"
          "/etc/NetworkManager/system-connections"
        ];
        files = [
          "/etc/machine-id"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
        ];
      };

  environment.persistence."/persist".users.uhdbits = {
    directories = [
      "nix-config"
    ];
  };

  boot.initrd = {
    supportedFilesystems = [ "btrfs" ];

    systemd.services.rollback = {
            description = "Rollback btrfs root subvolume to pristine state";
            wantedBy = [ "initrd.target" ];
            requires = [ "dev-disk-by\\x2dlabel-NixOS.device" ];
            after = [ "dev-disk-by\\x2dlabel-NixOS.device" ];
            before = [ "sysroot.mount" ];
            unitConfig.DefaultDependencies = "no";
            serviceConfig.Type = "oneshot";
            script = clearScript;
          };
    };
  }
