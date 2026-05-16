# Nix configuration file for basic nix/nixpkgs settings applied globally.
{
  inputs,
  lib,
  username,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      # Disable channels
      channel.enable = false;

      # General settings
      settings = {
        auto-optimise-store = true;

        # Specific experimental features
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        # Disable global flake registry
        flake-registry = "";
        # Make flake registry and nix path match flake inputs
        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

        # Build caching settings
        trusted-users = [ "${username}" ];
        substituters = [
          "https://nix-community.cachix.org"
          "https://attic.xuyh0120.win/lantian"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        ];

        # Prevent git dirty warning
        warn-dirty = false;
      };
    };
}
