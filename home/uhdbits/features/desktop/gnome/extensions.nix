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
    pkgs.gnomeExtensions.bangs-search
    pkgs.gnomeExtensions.battery-time-2
    pkgs.gnomeExtensions.bluetooth-battery-meter
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.brightness-control-using-ddcutil
    pkgs.gnomeExtensions.burn-my-windows
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.click-to-close-overview
    pkgs.gnomeExtensions.clipboard-indicator
    pkgs.gnomeExtensions.clipqr
    pkgs.gnomeExtensions.color-picker
    pkgs.gnomeExtensions.commands-store
    pkgs.gnomeExtensions.compact-top-bar
    pkgs.gnomeExtensions.control-monitor-brightness-and-volume-with-ddcutil
    pkgs.gnomeExtensions.cronomix
    pkgs.gnomeExtensions.custom-accent-colors
    pkgs.gnomeExtensions.custom-command-toggle
    pkgs.gnomeExtensions.custom-osd
    pkgs.gnomeExtensions.custom-reboot
    pkgs.gnomeExtensions.dash2dock-lite
    pkgs.gnomeExtensions.dock-from-dash
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.dynamic-panel
    pkgs.gnomeExtensions.easyScreenCast
    pkgs.gnomeExtensions.flickernaut
    pkgs.gnomeExtensions.force-quit
    pkgs.gnomeExtensions.forge
    pkgs.gnomeExtensions.fuzzy-app-search
    pkgs.gnomeExtensions.gnome-40-ui-improvements
    pkgs.gnomeExtensions.gsconnect
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.lilypad
    pkgs.gnomeExtensions.night-light-slider-updated
    pkgs.gnomeExtensions.no-titlebar-when-maximized
    pkgs.gnomeExtensions.on-the-top
    pkgs.gnomeExtensions.open-bar
    pkgs.gnomeExtensions.panel-corners
    pkgs.gnomeExtensions.pano
    pkgs.gnomeExtensions.pip-on-top
    pkgs.gnomeExtensions.printers
    pkgs.gnomeExtensions.tiling-assistant
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