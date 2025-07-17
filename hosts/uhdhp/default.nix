# NixOS configuration file for my HP ProBook 445 G9.
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    ./filesystem.nix
    ./hardware-configuration.nix
    ./ryzenadj.nix
    ./tlp.nix
    ../common/global
    ../common/optional/features/desktop/chromium.nix
    ../common/optional/features/desktop/warp.nix
    ../common/optional/features/desktop/gnome.nix

    # Common hardware imports to improve AMD CPU/GPU support.
    ../common/optional/hardware/cpu/amd
    ../common/optional/hardware/cpu/amd/pstate.nix
    ../common/optional/hardware/cpu/amd/zenpower.nix
    ../common/optional/hardware/gpu/amd

    # Common TLP imports in order to make sure TLP functions.
    ../common/optional/hardware/laptop/tlp.nix

    # Other miscellaneous common hardware related imports.
    ../common/optional/hardware/sound
    ../common/optional/hardware/ssd
    ../common/optional/hardware/peripherals/fingerprint.nix
    ../common/optional/hardware/peripherals/printing.nix

    # Common UEFI imports to customize the bootloader and enable secure boot.
    ../common/optional/boot/systemd-boot.nix
    ../common/optional/boot/secureboot.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  # Encrypted partition
  #boot.initrd.luks.devices = {
  #  root = {
  #    device = "/dev/nvme0n1p3";
  #    preLVM = true;
  #  };
  #};

  # TODO: Set your hostname
  networking.hostName = "uhdhp";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install GnuPG
  programs.gnupg.agent.enable = true;

  # Install the fish shell.
  programs.fish.enable = true;

  services.flatpak.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs pkgs;
    };
    users = {
      uhdbits = import ../../home/uhdbits/uhdhp.nix;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
