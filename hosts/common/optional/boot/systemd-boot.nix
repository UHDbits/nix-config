# Nix configuration file to configure and enable the systemd-boot bootloader.
{ lib, ... }:
{
  boot.loader.systemd-boot = {
    enable = true;

    configurationLimit = lib.mkDefault 5;
    editor = lib.mkDefault false;
  };
}
