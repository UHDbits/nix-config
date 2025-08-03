# Nix configuration file to configure basic Bluetooth settings.
{ lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = lib.mkDefault false;
  }
}