{ config, lib, ... }:
{
  config = lib.mkIf (config.desktop == "cosmic") {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
  };
}
