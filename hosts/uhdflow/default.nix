{ pkgs, scanPaths, ... }:
{
  imports = scanPaths ./.;

  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
    loader.limine.extraEntries = ''
      /Bazzite
        protocol: efi
        path: boot():/EFI/fedora/shimx64.efi

      /Windows
        protocol: efi
        path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
  desktop = "niri";
  home-manager.users.uhdbits.wayland.windowManager.niri.settings.output = {
    _args = [ "eDP-1" ];
    scale = 1.5;
  };
  networking.hostName = "uhdflow";
  storage = {
    bootDevice = "/dev/disk/by-label/EFI";
    device = "/dev/disk/by-uuid/a22dde1c-56df-4aff-9945-4d3b82615287";
    enable = true;
    luks.mode = "passphrase";
  };
  swap = {
    enable = true;
    fileSizeMiB = 16384;
    mode = "zswap+file";
  };
  system.stateVersion = "26.11";
}
