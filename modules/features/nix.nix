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
      substituters = [
        "https://attic.xuyh0120.win/lantian"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
}
