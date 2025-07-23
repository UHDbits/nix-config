{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnomeExtensions.accent-directories
    pkgs.gnomeExtensions.adw-gtk3-colorizer
    pkgs.gnomeExtensions.advanced-alttab-window-switcher
    pkgs.gnomeExtensions.alphabetical-app-grid
    pkgs.gnomeExtensions.alt-tab-current-monitor
    pkgs.gnomeExtensions.app-grid-wizard
    pkgs.gnomeExtensions.argos
    pkgs.gnomeExtensions.auto-accent-colour
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.commands-store
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.printers
    pkgs.gnomeExtensions.weekly-commits
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.gmail.com"
      ];
    };
  };
}