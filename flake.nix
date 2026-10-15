{
  description = "NixOS configuration by Ashton A.";

  nixConfig = {
    extra-substituters = [
      "https://attic.xuyh0120.win/lantian"
      "https://nix-community.cachix.org"
      "https://z13helper.cachix.org"
    ];
    extra-trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "z13helper.cachix.org-1:61FSuMX5PXPjeOcHBnYpjcCkGpWANoahaubcLYEn9HA="
    ];
  };

  inputs = {
    claude-desktop-extra = {
      url = "github:patrickjaja/claude-desktop-extra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codex-desktop-linux = {
      url = "github:ilysenko/codex-desktop-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
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
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    t2fanrd = {
      url = "github:GnomedDev/T2FanRD";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    z13helper.url = "github:UHDbits/z13helper";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
      lib = import ./lib { inherit (nixpkgs) lib; };
      specialArgs = {
        inherit inputs;
        inherit (lib) scanPaths;
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      nixosConfigurations = {
        uhdair = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./modules/base
            ./hosts/uhdair
          ];
        };
        uhdflow = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./modules/base
            ./hosts/uhdflow
          ];
        };
      };
    };
}
