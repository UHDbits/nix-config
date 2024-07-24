# Nix configuration file to set general settings for SSDs.
{ lib, ... }:
{
  # Enable SSD TRIM.
  services.fstrim.enable = lib.mkDefault true;
}
