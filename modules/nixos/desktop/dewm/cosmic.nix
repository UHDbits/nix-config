# NixOS configuration file to setup COSMIC with cosmic-greeter.
{ lib, pkgs, ... }:
{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = lib.mkDefault true;
  };
}
