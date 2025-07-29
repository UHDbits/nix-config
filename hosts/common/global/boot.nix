# Nix configuration file to configure basic boot settings.

{
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      # Enable systemd initrd.
      systemd.enable = true;
    };

    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    tmp.cleanOnBoot = true;
}