# NixOS configuration file for generated hardware configuration parameters for UHDair.
{ lib, ... }:
{
  boot.initrd.availableKernelModules = [ "nvme" ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
      "subvol=root"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "compress=zstd"
      "noatime"
      "subvol=nix"
    ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "compress=zstd"
      "noatime"
      "subvol=persist"
    ];
  };


  fileSystems."/.swap" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "btrfs";
    options = [
      "noatime"
      "nodatacow"
      "nodatasum"
      "subvol=swap"
    ];
  };

  swapDevices = [
    {
      device = "/.swap/swapfile";
      size = 8192;
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
