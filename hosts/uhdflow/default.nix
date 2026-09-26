{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./z13helper.nix
  ];

  networking.hostName = "uhdflow";
  desktop = "niri";
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
  boot.loader.limine.extraEntries = ''
    /Bazzite
      protocol: efi
      path: boot():/EFI/fedora/shimx64.efi

    /Windows
      protocol: efi
      path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';
}
