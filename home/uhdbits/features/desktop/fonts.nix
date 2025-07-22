# Nix configuration file to add specific fonts to the system.
{ pkgs, ... }:
{
  home.packages =
    [
      pkgs.inter
      pkgs.roboto
    ];
}