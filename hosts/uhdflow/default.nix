{ pkgs, ... }:
{
  imports = [ ./hardware.nix ];

  networking.hostName = "uhdflow";
  desktop = "cosmic";
  secureBoot.enable = false;
  storage = {
    bootDevice = "/dev/disk/by-label/EFI";
    device = "/dev/disk/by-uuid/a22dde1c-56df-4aff-9945-4d3b82615287";
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
