{ pkgs, ... }:
{
  home.packages = [
    pkgs.nixfmt-rfc-style
    pkgs.nixd
    pkgs.deadnix
    pkgs.ddcutil
    pkgs.lm_sensors
    pkgs.imagemagick
    pkgs.jdk21
    pkgs.gitkraken  
  ];

  programs.nix-index.enable = true;
}
