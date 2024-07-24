# Nix configuration file to enable the "acpi_call" kernel module in order to ensure tlp functionality.
{ config, lib, ... }:
{
  boot = lib.mkIf config.services.tlp.enable {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };
}
