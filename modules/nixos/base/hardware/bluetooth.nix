# NixOS configuration file to configure basic Bluetooth settings.
{ lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = lib.mkDefault false;
    settings = {
      General = {
        # Enable battery reading
        Experimental = lib.mkDefault true;
      };
    };
  };

  services.blueman.enable = lib.mkDefault true;
}
