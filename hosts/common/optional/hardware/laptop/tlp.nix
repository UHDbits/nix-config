# Nix configuration file to set general laptop settings.
{ lib, ... }:
{
  # Disable power-profiles daemon (conflicts with tlp).
  services.power-profiles-daemon.enable = lib.mkForce false;

  # Enable tlp.
  services.tlp.enable = lib.mkDefault true;
}
