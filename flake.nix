# Nix configuration file for a flake-based configuration.
{
  # Inputs, the dependencies (online or local) of this flake.
  inputs = {
    frc-nix.url = {
      url = "github:frc4451/frc-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
}
