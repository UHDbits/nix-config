# NixOS configuration file for my 2020 Intel MacBook Air.
{
  lib,
  modulesPath,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    ../common/global
    ../common/users/uhdbits.nix
    ../common/optional/features/adb.nix
    ../common/optional/features/appimage.nix
    ../common/optional/features/fish.nix
    ../common/optional/features/flatpak.nix
    ../common/optional/features/gnupg.nix
    ../common/optional/features/security.nix
    ../common/optional/features/zswap.nix
    ../common/optional/features/desktop/chromium.nix
    ../common/optional/features/desktop/dewm/gnome.nix

    # Common TLP imports in order to make sure TLP functions.
    ../common/optional/hardware/laptop/tlp.nix

    # Other miscellaneous common hardware related imports.
    ../common/optional/hardware/sound.nix
    ../common/optional/hardware/ssd.nix
    ../common/optional/hardware/peripherals/printing.nix

    # Common UEFI imports to customize the bootloader and enable secure boot.
    ../common/optional/boot/quietboot.nix
    ../common/optional/boot/systemd-boot.nix

    inputs.home-manager.nixosModules.home-manager
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    users = {
      uhdbits = import ../../home/uhdbits/uhdair.nix;
    };
  };


  nix.settings = {
    substituters = [ "https://cache.soopy.moe" ];
    trusted-substituters = [ "https://cache.soopy.moe" ];
    trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "uhdair";

  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}