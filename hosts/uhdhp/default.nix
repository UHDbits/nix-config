# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
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

    # Common UEFI imports to customize the bootloader and enable secure boot.
    ../common/optional/boot/systemd-boot.nix
    ../common/optional/boot/secureboot.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.frc-nix.overlays.default

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install GnuPG
  programs.gnupg.agent.enable = true;

  # Install the fish shell.
  programs.fish.enable = true;

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
