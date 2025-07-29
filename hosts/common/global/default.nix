# Nix configuration file for default configurations applied globally.
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./users/uhdbits/default.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.rebuild.enableNg = true;

  # Setup nixpkgs
  nixpkgs = {
    overlays = [ inputs.frc-nix.overlays.default ];

    config = {
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
}
