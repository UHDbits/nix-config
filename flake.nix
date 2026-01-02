# Nix configuration file for a flake-based configuration.
{
  description = "Personal NixOS and Home Manager configuration made by UHDbits/Ashton A.";

  # Inputs, the dependencies (online or local) of this flake.
  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";

    nixpkgs-stable.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-25.05";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    frc-nix = {
      url = "github:frc4451/frc-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  # Outputs, what the flake creates.
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
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
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/uhdhp ];
        };

        # Secondary system, 2020 Intel MacBook Air
        uhdair = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs ; };
          modules = [
            ./hosts/uhdair
            nixos-hardware.nixosModules
          ];
        }
      };
    };
}
