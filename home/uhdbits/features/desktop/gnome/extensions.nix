{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.cloudflare-warp-toggle
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "cloudflare-warp-toggle@khaled.is-a.dev"
      ];
    };
  };
}