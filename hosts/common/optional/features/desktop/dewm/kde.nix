# Nix configuration file to setup KDE with SDDM.
{ pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    }
  }
}