# NixOS configuration file for generic hardware settings.
{ lib, ... }:
{
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
