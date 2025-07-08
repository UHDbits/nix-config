# Nix configuration file to set general laptop settings.
{ config, lib, ... }:
{
  # Enable "acpi_call" to ensure proper TLP functionality.
  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  # Disable power-profiles daemon (conflicts with tlp).
  services.power-profiles-daemon.enable = lib.mkForce false;

  # Enable tlp.
  services.tlp.enable = lib.mkDefault true;
}
