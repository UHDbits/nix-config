{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnomeExtensions.accent-directories # Done
    pkgs.gnomeExtensions.adw-gtk3-colorizer # Done
    pkgs.gnomeExtensions.advanced-alttab-window-switcher
    pkgs.gnomeExtensions.alphabetical-app-grid
    pkgs.gnomeExtensions.alt-tab-current-monitor
    pkgs.gnomeExtensions.auto-accent-colour
    pkgs.gnomeExtensions.bangs-search
    pkgs.gnomeExtensions.battery-time-2 # Done
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.brightness-control-using-ddcutil
    pkgs.gnomeExtensions.burn-my-windows
    pkgs.gnomeExtensions.caffeine # Enabled, configure settings
    pkgs.gnomeExtensions.click-to-close-overview # Done
    pkgs.gnomeExtensions.clipboard-indicator
    pkgs.gnomeExtensions.clipqr
    pkgs.gnomeExtensions.color-picker # Enabled, configure settings
    pkgs.gnomeExtensions.compact-top-bar
    pkgs.gnomeExtensions.control-monitor-brightness-and-volume-with-ddcutil
    pkgs.gnomeExtensions.custom-command-toggle
    pkgs.gnomeExtensions.custom-reboot
    pkgs.gnomeExtensions.dash2dock-lite
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.dynamic-panel
    pkgs.gnomeExtensions.easyScreenCast
    pkgs.gnomeExtensions.flickernaut
    pkgs.gnomeExtensions.force-quit # Done
    pkgs.gnomeExtensions.fuzzy-app-search # Done
    pkgs.gnomeExtensions.gnome-40-ui-improvements
    pkgs.gnomeExtensions.gsconnect
    pkgs.gnomeExtensions.hide-top-bar
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.lilypad
    pkgs.gnomeExtensions.night-light-slider-updated
    pkgs.gnomeExtensions.open-bar
    pkgs.gnomeExtensions.pip-on-top # Done
    pkgs.gnomeExtensions.power-tracker # Done
    pkgs.gnomeExtensions.privacy-indicators-accent-color
    pkgs.gnomeExtensions.quick-settings-audio-devices-renamer
    pkgs.gnomeExtensions.quick-settings-audio-panel
    pkgs.gnomeExtensions.rectangle
    pkgs.gnomeExtensions.rounded-window-corners-reborn # Done
    pkgs.gnomeExtensions.signal-shell
    pkgs.gnomeExtensions.solaar-extension
    pkgs.gnomeExtensions.steal-my-focus-window
    pkgs.gnomeExtensions.tiling-assistant
    pkgs.gnomeExtensions.tiling-shell
    pkgs.gnomeExtensions.tactile
    pkgs.gnomeExtensions.window-gestures
  ];

  # Settings for extensions.
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "accent-directories@taiwbi.com"
        "adw-gtk3-colorizer@NiffirgkcaJ.github.com"
        "AlphabeticalAppGrid@stuarthayhurst"
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.gmail.com"
        "rounded-window-corners@fxgn"
      ];
    };

    "org/gnome/shell/extensions/accent-directories" = {
      change-app-colors = false;
    };
  };
}