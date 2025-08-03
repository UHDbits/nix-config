# Nix configuration file to set general settings for Intel CPUs.
{ config, lib, ... }:
{
  # Enable Intel microcode updates.
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}