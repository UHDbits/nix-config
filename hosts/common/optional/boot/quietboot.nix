# Nix configuration file to configure quiet boot settings.
{ lib, ... }:
{
  boot = {
    initrd = {
      verbose = false;
    };

    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=3"
    ];

    plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };
}