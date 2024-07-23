# Nix configuration file to set general UEFI boot settings.
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
      theme = "breeze";
    };

    # Enable systemd initrd.
    initrd.systemd.enable = true;

    # Set kernel parameters.
    kernelParams = ["quiet"];

    # Set the supported filesystems on boot.
    supportedFilesystems = [ "apfs" "bindfs" "btrfs" "ext4" "iso9600" "ntfs" "reiserfs" ];

    # Clear the "/tmp" folder on boot.
    tmp.cleanOnBoot = true;
  };
}