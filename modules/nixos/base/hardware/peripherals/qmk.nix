# NixOS configuration file to enable QMK keyboard support.
{ lib, ... }:
{
  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = lib.mkDefault true;
  };
}
