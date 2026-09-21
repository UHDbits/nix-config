{ pkgs, ... }:
{
  imports = [ ./hardware.nix ];

  networking.hostName = "uhdflow";
  desktop = "cosmic";
  secureBoot.enable = false;
  storage = {
    # Replace with this laptop's stable partition IDs before installation.
    bootDevice = "/dev/disk/by-label/EFI";
    device = "/dev/disk/by-label/NixOS";
    enable = true;
    impermanence.enable = true;
    luks = {
      mode = "passphrase";
      name = "cryptroot";
    };
  };
  system.stateVersion = "26.11";
  swap = {
    enable = true;
    fileSizeMiB = 16384;
    mode = "zswap+file";
    zramSizeMiB = 0;
  };

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
}
