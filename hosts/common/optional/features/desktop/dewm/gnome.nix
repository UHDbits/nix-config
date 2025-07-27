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
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gnome-characters
    gnome-connections
    gnome-software
    gnome-tour
    totem
  ];
}
