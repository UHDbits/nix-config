# NixOS configuration file for my Intel MacBook Air 2020.
{ lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    ../../modules/nixos/defaults/fulldesktop.nix
  ];

  networking.hostName = "uhdair";
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  programs.fish.enable = true;

  # temp boot config
  boot.loader.systemd-boot = {
      enable = true;

      configurationLimit = lib.mkDefault 5;
      editor = lib.mkDefault false;
    };

  # temp kernel config
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;
}
