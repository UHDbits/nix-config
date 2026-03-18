# Nix configuration file for a flake-based configuration.
{
  description = "Personal NixOS and Home Manager configuration made by UHDbits/Ashton A.";

  # Inputs, the dependencies (online or local) of this flake.
  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    frc-nix = {
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
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixos-hardware.url = "github:NixOS/nixos-hardware?shallow=1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable?shallow=1";
    nixpkgs-master.url = "github:nixos/nixpkgs/master?shallow=1";
    nur = {
      url = "github:nix-community/NUR?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  # Outputs, what the flake creates.
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      username = "uhdbits";
      inherit (self) outputs;

      # Compatible systems with this flake.
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Main formatter for this code, accessible through "nix fmt".
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

      nixosConfigurations = {
        # My main system, HP ProBook 445 G9
        uhdhp = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs username; };
          modules = [ ./hosts/uhdhp ];
        };
      };
    };
}
