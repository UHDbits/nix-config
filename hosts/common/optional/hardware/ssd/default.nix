# Nix configuration file to set general settings for SSDs.
{ lib, ... }:

{
  services.fstrim.enable = lib.mkDefault true;
}