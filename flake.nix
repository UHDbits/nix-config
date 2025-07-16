# Nix configuration file for a flake-based configuration.
{
  description = "Personal NixOS configuration made by UHDbits/Ashton A.";

  # Inputs, the dependencies (online or local) of this flake.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    frc-nix = {
      url = "github:frc4451/frc-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Main formatter for this code, accessible through "nix fmt"
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # My main system, HP ProBook 445 G9
        uhdhp = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            # > Our main nixos configuration file <
            ./hosts/uhdhp
          ];
        };
      };
    };
}
