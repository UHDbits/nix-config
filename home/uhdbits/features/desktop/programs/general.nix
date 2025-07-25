{ pkgs, ... }:
{
  home.packages = [
    pkgs.nixfmt-rfc-style
    pkgs.nixd
    pkgs.deadnix
    pkgs.ddcutil
    pkgs.lm_sensors
    pkgs.jdk21
    pkgs.bambu-studio
    pkgs.gitkraken
  ];
}