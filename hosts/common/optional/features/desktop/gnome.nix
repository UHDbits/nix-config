# Nix configuration file to setup GNOME with GDM.
{
  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    
    desktopManager.gnome.enable = true;
  };
}