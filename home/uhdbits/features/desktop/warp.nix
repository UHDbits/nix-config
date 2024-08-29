# Nix configuration file to enable Cloudflare WARP.
{ pkgs, ... }:
{
  # Install the cloudflare-warp package, and the WARP toggle for GNOME.
  home.packages = [
    pkgs.gnomeExtensions.cloudflare-warp-toggle
  ];

  # Add the toggle to the enabled extensions for GNOME.
}
