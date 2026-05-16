# NixOS configuration file for my Intel MacBook Air 2020.
{ lib, ... }:
{
  imports = [
    ../../modules/nixos/defaults/fulldesktop.nix
  ];

  networking.hostName = "uhdair";
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # temp boot config
  boot.loader.systemd-boot = {
      enable = true;

      configurationLimit = lib.mkDefault 5;
      editor = lib.mkDefault false;
    };
}
