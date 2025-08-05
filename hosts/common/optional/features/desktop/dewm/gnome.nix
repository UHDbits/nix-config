# Nix configuration file to setup GNOME with GDM.
{ pkgs, ... }:
{
  services = {
    desktopManager.gnome.enable = true;
    
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Temporarily fix fast login Authentication Failure (https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229)
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

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
