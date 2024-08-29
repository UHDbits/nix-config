# Nix configuration file to install FRC related packages.
{ pkgs, inputs, ... }:
{
  home.packages = [ inputs.frc-nix.packages.x86_64-linux.elastic-dashboard ];
}
