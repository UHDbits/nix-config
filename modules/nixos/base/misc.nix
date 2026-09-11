# NixOS configuration for generic base configurations.
{
  hardware.usbStorage.manageShutdown = true;
  services.fwupd.enable = true;
  services.upower.enable = true;
}
