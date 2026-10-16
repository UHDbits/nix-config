{ inputs, pkgs, ... }:
{
  imports = [
    inputs.t2fanrd.nixosModules.t2fanrd
    ./audio.nix
    ./hardware.nix
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;
  desktop = "cosmic";
  networking.hostName = "uhdair";
  powerManagement.enable = true;
  secureBoot.enable = false;
  services.t2fanrd = {
    config.Fan1 = { };
    enable = true;
  };
  storage = {
    # Replace with this laptop's stable partition IDs before installation.
    bootDevice = "/dev/disk/by-label/EFI";
    device = "/dev/disk/by-label/NixOS";
    enable = true;
    impermanence.enable = true;
    luks = {
      mode = "none";
      name = "cryptroot";
    };
  };
  swap = {
    enable = true;
    fileSizeMiB = 8192;
    mode = "zram+file";
    zramSizeMiB = 4096;
  };
  system.stateVersion = "26.11";
}
