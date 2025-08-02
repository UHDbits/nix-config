# Nix configuration file to configure and enable the Limine bootloader, mainly for MBR/BIOS boot.
{ lib, ... }:
{
  boot.loader.limine = {
    enable = true;

    # Assume /dev/sda, must override if something different.
    biosDevice = lib.mkDefault "/dev/sda";
    enableEditor = lib.mkDefault false;
    maxGeneration = lib.mkDefault 5;
  };
}
