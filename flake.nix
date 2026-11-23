{
  description = "NixOS configuration by Ashton A.";

  inputs = {
    claude-desktop-extra = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:patrickjaja/claude-desktop-extra";
    };
    codex-desktop-linux = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ilysenko/codex-desktop-linux";
    };
    helium = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxcl/nix-flake-helium-browser";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    impermanence = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/impermanence";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };
    nixos-hardware = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:NixOS/nixos-hardware";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/NUR";
    };
    wallpapers = {
      flake = false;
      url = "git+https://github.com/UHDbits/wallpapers?lfs=1";
    };
    z13helper.url = "github:UHDbits/z13helper";
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.lantian.pub/lantian"
      "https://nix-community.cachix.org"
      "https://z13helper.cachix.org"
    ];
    extra-trusted-public-keys = [
      "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "z13helper.cachix.org-1:61FSuMX5PXPjeOcHBnYpjcCkGpWANoahaubcLYEn9HA="
    ];
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      lib = import ./lib { inherit (nixpkgs) lib; };
      specialArgs = {
        inherit inputs;
        inherit (lib) scanPaths;
      };
      system = "x86_64-linux";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      nixosConfigurations = {
        uhdflow = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = [
            ./modules/base
            ./hosts/uhdflow
          ];
        };
        uhdprobook = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = [
            ./modules/base
            ./hosts/uhdprobook
          ];
        };
      };
    };
}
