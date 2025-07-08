# Nix configuration file to enable Secure Boot on UEFI systems.
###############################################################
# Before using this file, make sure the system is prepared using the directions at:
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  users.users.uhdbits.packages = [
    pkgs.sbctl
  ];

  # Disable systemd-boot (replaced by Lanzaboote).
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable Lanzaboote and set key location.
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
