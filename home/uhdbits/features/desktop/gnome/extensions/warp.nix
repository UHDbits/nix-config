# Nix configuration file to enable Cloudflare WARP.
{ pkgs, ... }:
{
  # Install the WARP toggle for GNOME.
  home.packages = [
    pkgs.gnomeExtensions.cloudflare-warp-toggle
  ];

  # Add the toggle to the enabled extensions for GNOME.
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "cloudflare-warp-toggle@khaled.is-a.dev"
      ];
    };
  };
}
