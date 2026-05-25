# NixOS configuration file for basic hardware settings.
{ lib, ... }:
{
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Bluetooth Settings
  hardware.bluetooth = {
    enable = lib.mkDefault true;
    powerOnBoot = lib.mkDefault false;
    settings = {
      General = {
        # Enable battery reading/LE Audio
        Experimental = lib.mkDefault true;
        KernelExperimental = lib.mkDefault true;
      };
    };
  };

  # Printing settings
  services.printing = {
    browsed.enable = false;
    enable = lib.mkDefault true;
    webInterface = false;
  };
  # Enable the IPP everywhere protocol
  services.avahi = {
    enable = lib.mkDefault true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.ipp-usb.enable = true;

  # QMK (keyboard) settings
  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = true;
  };

  # Sound settings
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Wireless/WiFi settings
  networking.wireless = {
    enable = lib.mkDefault false;
    iwd.enable = lib.mkDefault true;
  };
}
