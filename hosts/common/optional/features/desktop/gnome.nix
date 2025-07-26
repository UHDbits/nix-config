# Nix configuration file to setup GNOME with GDM.
{ pkgs, ... }:
{
  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    desktopManager.gnome.enable = true;
  };

  # Default GNOME apps to exclude.
  environment.gnome.excludePackages = [
    pkgs.decibels
    pkgs.geary
    pkgs.gnome-software
    pkgs.gnome-tour
    pkgs.totem
  ];
}
