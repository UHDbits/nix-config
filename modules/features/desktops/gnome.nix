{ config, lib, ... }:
{
  config = lib.mkIf (config.desktop == "gnome") {
    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
