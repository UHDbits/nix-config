{
  ...
}:
{
  environment.persistence."/persist".directories = [
    {
      directory = "/etc/NetworkManager/system-connections";
      group = "root";
      mode = "0700";
      user = "root";
    }
    "/var/lib/NetworkManager"
    {
      directory = "/var/lib/bluetooth";
      group = "root";
      mode = "0700";
      user = "root";
    }
    {
      directory = "/var/lib/cups";
      group = "root";
      mode = "0755";
      user = "root";
    }
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General = {
      Experimental = true;
      KernelExperimental = true;
    };
  };

  networking.networkmanager.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    fwupd.enable = true;
    ipp-usb.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    upower.enable = true;
  };
}
