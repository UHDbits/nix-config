{ pkgs, scanPaths, ... }:
{
  imports = scanPaths ./.;

  boot = {
    # Zen 3 has AVX2 but no AVX-512, so x86-64-v3 is the newest usable target.
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    loader.limine.extraEntries = ''
      /CachyOS
        protocol: efi
        path: boot():/EFI/systemd/systemd-bootx64.efi

      /Windows
        protocol: efi
        path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
  desktop = "niri";
  home-manager.users.uhdbits.wayland.windowManager.niri.settings.output = {
    _args = [ "eDP-1" ];
    scale = 1.0;
  };
  networking.hostName = "uhdprobook";
  storage = {
    bootDevice = "/dev/disk/by-partuuid/0e5ca0c7-0d34-402f-9507-a77f81444e51";
    # PARTUUID survives reformatting the partition as a LUKS2 container.
    device = "/dev/disk/by-partuuid/44fd9c3b-9018-40ca-9e0a-5a9f77c134a6";
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
