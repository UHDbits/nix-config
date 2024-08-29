# Nix configuration file to install FRC related packages.
{ pkgs, inputs, ... }:
{
  home.packages = [ pkgs.frc.elastic-dashboard ];
}
