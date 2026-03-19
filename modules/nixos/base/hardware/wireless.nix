{ lib, ... }:
{
  networking.wireless = {
    enable = lib.mkDefault false;
    iwd.enable = lib.mkDefault true;
  };
}
