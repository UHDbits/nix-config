# Nix configuration file to set general settings for AMD CPUs.
{ config, lib, ... }:

{
  # Enable AMD microcode updates.
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}