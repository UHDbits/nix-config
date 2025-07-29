# Nix configuration file to configure and enable the systemd-boot bootloader.
{ lib, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;

        configurationLimit = lib.mkDefault 5;
        editor = lib.mkDefault false;
      };

      efi.canTouchEfiVariables = lib.mkDefault true;

      timeout = lib.mkDefault 10;
    };
  };
}
