{ config, lib, ... }:
{
  config = lib.mkIf (config.desktop == "gnome") {
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
  };
}
