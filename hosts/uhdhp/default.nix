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
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./ryzenadj.nix
    ./tlp.nix
    ../common/global
    ../common/optional/hardware/cpu/amd
    ../common/optional/hardware/cpu/amd/pstate.nix
    ../common/optional/hardware/cpu/amd/zenpower.nix
    ../common/optional/hardware/gpu/amd
    ../common/optional/hardware/laptop/acpi.nix
    ../common/optional/hardware/laptop/tlp.nix
    ../common/optional/hardware/sound
    ../common/optional/hardware/ssd
    ../common/optional/uefi/boot.nix
    ../common/optional/uefi/secureboot.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p3";
      preLVM = true;
    };
  };

  # TODO: Set your hostname
  networking.hostName = "uhdhp";

  hardware.amdgpu.initrd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = [
    pkgs.nixfmt-rfc-style
    pkgs.nixd
    pkgs.deadnix
    pkgs.lm_sensors
    pkgs.floorp
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Install GnuPG
  programs.gnupg.agent.enable = true;

  # Install the fish shell.
  programs.fish.enable = true;

  # Set Chromium settings.
  programs.chromium = {
    enable = true;
    # Set various policies.
    extraOpts = {
      # Disable Background Mode.
      "BackgroundModeDisabled" = true;

      # Clear browsing data on exit.
      "ClearBrowsingDataOnExitList" = [
        "browsing_history"
        "download_history"
        "cookies_and_other_site_data"
        "cached_images_and_files"
      ];

      # Set a custom profile label.
      "CustomProfileLabel" = "UHDbits";

      # Set the default search engine.
      "DefaultSearchProviderEnabled" = true;
      "DefaultSearchProviderName" = "Google";
      "DefaultSearchProviderSearchURL" = "{google:baseURL}search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:searchClient}{google:sourceId}ie={inputEncoding}";
      "DefaultSearchProviderSuggestURL" = "{google:baseURL}complete/search?output=chrome&q={searchTerms}";
      "DefaultSearchProviderImageURL" = "{google:baseURL}searchbyimage/upload";
      "DefaultSearchProviderImageURLPostParams" = "encoded_image={google:imageThumbnail},image_url={google:imageURL},sbisrc={google:imageSearchSource},original_width={google:imageOriginalWidth},original_height={google:imageOriginalHeight}";
      "DefaultSearchProviderKeyword" = "google";

      # Disable restore on startup.
      "RestoreOnStartup" = 5;
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = false;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs pkgs;
    };
    users = {
      uhdbits = import ../../home/uhdbits/uhdhp.nix;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
