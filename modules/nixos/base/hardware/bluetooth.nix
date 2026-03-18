# NixOS configuration file to configure basic Bluetooth settings.
{ lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = lib.mkDefault false;
  };

  services.blueman.enable = lib.mkDefault true;
}
