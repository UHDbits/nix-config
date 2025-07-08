# Nix configuration file to set general UEFI boot settings.
{ pkgs, ... }:
{
  # Set boot settings.
  boot = {
    # Set loader settings.
    loader = {
      # Set settings for systemd-boot.
      systemd-boot = {
        # Enable systemd-boot.
        enable = true;
        # Disable the parameter editor.
        editor = false;
        # Lower the max NixOS configuration limit to 5.
        configurationLimit = 5;
      };

      # Allow EFI variables to be modified.
      efi.canTouchEfiVariables = true;

      # Set loader timeout to 10 seconds.
      timeout = 10;
    };

    # Set Plymouth settings.
    plymouth = {
      # Enable Plymouth.
      enable = true;
      # Set Plymouth theme.
      theme = "bgrt";
    };

    # Set the kernel packages to be based on the latest versions.
    kernelPackages = pkgs.linuxPackages_latest;

    # Set initrd settings.
    initrd = {
      # Enable systemd initrd.
      systemd.enable = true;
      # Disable verbose output.
      verbose = false;
    };

    # Set kernel parameters.
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    # Set the console log level.
    consoleLogLevel = 0;

    # Set the supported filesystems on boot.
    supportedFilesystems = [
      "bindfs"
      "btrfs"
      "ext4"
      "iso9600"
      "ntfs"
      "reiserfs"
    ];

    # Clear the "/tmp" folder on boot.
    tmp.cleanOnBoot = true;
  };
}
