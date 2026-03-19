# NixOS configuration file to set general TuneD settings.
{ lib, ... }:
{
  # Disable power-profiles daemon (conflicts with tuned).
  services.power-profiles-daemon.enable = lib.mkForce false;

  # Enable tuned.
  services.tuned.enable = lib.mkDefault true;
}
