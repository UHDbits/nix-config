{ config, lib, ... }:
{
  config = lib.mkIf (config.desktop == "cosmic") {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
