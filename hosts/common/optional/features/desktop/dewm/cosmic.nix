# NixOS configuration file to setup the COSMIC DE.
{ pkgs, ... }:
{
  # Enable COSMIC DE/login manager.
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  # Enable system76-scheduler for potentially better performance.
  services.system76-scheduler.enable = true;

  # Disable Firefox libadwaita colors.
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}