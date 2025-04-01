# Nix configuration file to enable and configure "blur-my-shell" for GNOME.
{ pkgs, ... }:
{
  # Install blur-my-shell.
  home.packages = [
    pkgs.gnomeExtensions.blur-my-shell
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
      ];
    };
  };
}
