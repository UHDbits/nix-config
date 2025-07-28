# Nix configuration file to set basic EFI boot settings, using systemd-boot as the default.
{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 5;
      };

      # Allow EFI variables to be modified.
      efi.canTouchEfiVariables = true;

      timeout = 10;
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      # Enable systemd initrd.
      systemd.enable = true;
      # Disable verbose output.
      verbose = false;
    };

    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    consoleLogLevel = 0;

    tmp.cleanOnBoot = true;
  };
}
