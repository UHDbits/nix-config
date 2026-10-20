{ inputs, ... }:
{
  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      flake-registry = "";
      # Re-add it only with a newly published key: https://github.com/xddxdd/nix-cachyos-kernel/issues/110
      substituters = [
        "https://nix-community.cachix.org"
        "https://z13helper.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "z13helper.cachix.org-1:61FSuMX5PXPjeOcHBnYpjcCkGpWANoahaubcLYEn9HA="
      ];
      trusted-users = [
        "root"
        "uhdbits"
      ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  };

  programs.nix-ld.enable = true;
}
