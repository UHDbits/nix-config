# Nix configuration file to configure basic boot settings.
{ lib, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = lib.mkDefault true;
      timeout = lib.mkDefault 10;
    };

    tmp.cleanOnBoot = lib.mkDefault true;
  };
}
