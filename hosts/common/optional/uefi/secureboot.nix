# Nix configuration file to enable Secure Boot on UEFI systems.
###############################################################
# Before using this file, make sure the system is prepared using the directions at:
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  # Import the lanzaboote module.
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Add sbctl to system packages to make debugging and troubleshooting easier.
  environment.systemPackages = [
    pkgs.sbctl
  ];

  # Disable systemd-boot (replaced by Lanzaboote).
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable Lanzaboote and set key location
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}