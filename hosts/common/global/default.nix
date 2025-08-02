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
  ];

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
        experimental-features = "nix-command flakes";
        trusted-users = [ "root" "@wheel" ];
        warn-dirty = false;
      };

      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
}
