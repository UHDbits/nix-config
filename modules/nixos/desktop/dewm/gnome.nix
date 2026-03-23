# NixOS configuration file to setup GNOME with GDM.
{ pkgs, ... }:
{
  services = {
    desktopManager.gnome = enable;

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  }
}
