{ pkgs, ... }:
{
  home.packages = [
    # GNOME JavaScript engine
    pkgs.gjs

    # Extensions
    pkgs.gnomeExtensions.accent-directories # Done
    pkgs.gnomeExtensions.adw-gtk3-colorizer # Done
    pkgs.gnomeExtensions.alphabetical-app-grid # Done
    pkgs.gnomeExtensions.alt-tab-current-monitor # Done
    pkgs.gnomeExtensions.auto-accent-colour # Done
    pkgs.gnomeExtensions.bangs-search
    pkgs.gnomeExtensions.battery-time-2 # Done
    pkgs.gnomeExtensions.blur-my-shell # Enabled, configure settings
    pkgs.gnomeExtensions.brightness-control-using-ddcutil
    pkgs.gnomeExtensions.burn-my-windows
    pkgs.gnomeExtensions.caffeine # Enabled, configure settings
    pkgs.gnomeExtensions.click-to-close-overview # Done
    pkgs.gnomeExtensions.clipboard-indicator # Done
    pkgs.gnomeExtensions.clipqr # Done
    pkgs.gnomeExtensions.color-picker # Enabled, configure settings
    pkgs.gnomeExtensions.compact-top-bar
    pkgs.gnomeExtensions.control-monitor-brightness-and-volume-with-ddcutil
    pkgs.gnomeExtensions.custom-command-toggle
    pkgs.gnomeExtensions.custom-reboot
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.easyScreenCast # Enabled, configure settings
    pkgs.gnomeExtensions.flickernaut # Enabled, configure settings
    pkgs.gnomeExtensions.force-quit # Done
    pkgs.gnomeExtensions.fuzzy-app-search # Done
    pkgs.gnomeExtensions.gnome-40-ui-improvements
    pkgs.gnomeExtensions.gsconnect
    pkgs.gnomeExtensions.hide-top-bar # Done
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.lilypad # Enabled, configure settings
    pkgs.gnomeExtensions.night-light-slider-updated
    pkgs.gnomeExtensions.open-bar
    pkgs.gnomeExtensions.pip-on-top # Done
    pkgs.gnomeExtensions.quick-settings-audio-devices-renamer # Enabled, configure settings
    pkgs.gnomeExtensions.quick-settings-audio-panel # Done
    pkgs.gnomeExtensions.rectangle # Enabled, configure settings
    pkgs.gnomeExtensions.rounded-window-corners-reborn # Done
    pkgs.gnomeExtensions.signal-shell
    pkgs.gnomeExtensions.solaar-extension
    pkgs.gnomeExtensions.tiling-assistant # Enabled, configure settings
    pkgs.gnomeExtensions.tiling-shell # Enabled, configure settings
    pkgs.gnomeExtensions.tactile # Enabled, configure settings
    pkgs.gnomeExtensions.window-gestures # Enabled, configure settings
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