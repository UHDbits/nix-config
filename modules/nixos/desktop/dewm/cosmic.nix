# NixOS configuration file to setup COSMIC with cosmic-greeter.
{ lib, pkgs, ... }:
{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter = lib.mkDefault true;
  }
}
