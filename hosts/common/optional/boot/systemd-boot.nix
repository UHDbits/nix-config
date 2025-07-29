# Nix configuration file to set settings and enable the systemd-boot bootloader.
{ lib, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;

        configurationLimit = lib.mkDefault 5;
        editor = lib.mkDefault false;
      };

      # Allow EFI variables to be modified.
      efi.canTouchEfiVariables = true;

      timeout = 10;
    };
  };
}
