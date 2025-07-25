{ pkgs, ... }:
{
  home.packages = [
    # GNOME JavaScript engine
    pkgs.gjs

    # Extensions
    pkgs.gnomeExtensions.accent-directories
    pkgs.gnomeExtensions.adw-gtk3-colorizer
    pkgs.gnomeExtensions.alphabetical-app-grid
    pkgs.gnomeExtensions.alt-tab-current-monitor
    pkgs.gnomeExtensions.auto-accent-colour
    pkgs.gnomeExtensions.battery-time-2
    pkgs.gnomeExtensions.blur-my-shell # Double check configured settings
    pkgs.gnomeExtensions.brightness-control-using-ddcutil # Compare to other ddcutil one
    pkgs.gnomeExtensions.burn-my-windows # Check how to configure through nix/home-manager
    pkgs.gnomeExtensions.caffeine # Check settings
    pkgs.gnomeExtensions.click-to-close-overview
    pkgs.gnomeExtensions.clipboard-indicator # Check excluded apps
    pkgs.gnomeExtensions.clipqr
    pkgs.gnomeExtensions.color-picker
    pkgs.gnomeExtensions.control-monitor-brightness-and-volume-with-ddcutil # Compare to other ddcutil one
    pkgs.gnomeExtensions.custom-command-toggle # Add toggle maybe for ryzenadj/tlp or something else
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.easyScreenCast # Check performance and stuttering
    pkgs.gnomeExtensions.flickernaut # Configure settings
    pkgs.gnomeExtensions.force-quit
    pkgs.gnomeExtensions.fuzzy-app-search
    pkgs.gnomeExtensions.gsconnect # Check if want to use
    pkgs.gnomeExtensions.hide-top-bar
    pkgs.gnomeExtensions.lilypad # Configure
    pkgs.gnomeExtensions.pip-on-top
    pkgs.gnomeExtensions.quick-settings-audio-devices-renamer # Finish configuration
    pkgs.gnomeExtensions.quick-settings-audio-panel
    pkgs.gnomeExtensions.rectangle
    pkgs.gnomeExtensions.rounded-window-corners-reborn
    pkgs.gnomeExtensions.signal-shell # Configure
    pkgs.gnomeExtensions.solaar-extension
    pkgs.gnomeExtensions.tiling-assistant # Enabled, configure settings
    pkgs.gnomeExtensions.tiling-shell # Enabled, configure settings
    pkgs.gnomeExtensions.window-gestures # Enabled, configure settings
  ];

  # Settings for extensions.
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "accent-directories@taiwbi.com"
        "adw-gtk3-colorizer@NiffirgkcaJ.github.com"
        "AlphabeticalAppGrid@stuarthayhurst"
        "alt-tab-current-monitor@esauvisky.github.io"
        "auto-accent-colour@Wartybix"
        "batterytime@typeof.pw"
        "blur-my-shell@aunetx"
        "burn-my-windows@schneegans.github.com"
        "caffeine@patapon.info"
        "click-to-close-overview@l3nn4rt.github.io"
        "clipqr@drien.com"
        "color-picker@tuberry"
        "custom-command-toggle@storageb.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "EasyScreenCast@iacopodeenosee.gmail.com"
        "flickernaut@imoize.github.io"
        "fq@megh"
        "gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com"
        "hidetopbar@mathieu.bidon.ca"
        "lilypad@shendrew.github.io"
        "quicksettings-audio-devices-renamer@marcinjahn.com"
        "pip-on-top@rafostar.github.com"
        "quick-settings-audio-panel@rayzeq.github.io"
        "rectangle@acristoffers.me"
        "rounded-window-corners@fxgn"
        "solaar-extension@sidevesh"
      ];
    };

    "org/gnome/shell/extensions/accent-directories" = {
      change-app-colors = false;
    };

    "org/gnome/shell/extensions/auto-accent-colour" = {
      hide-indicator = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      static-blur = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = {
      compatibility = true; # Might not be needed?
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      unblur-in-overview = false;
    };

    "org/gnome/shell/extensions/caffeine" = {
      enable-fullscreen = false;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      dash-max-icon-size = 42;
      hot-keys = false;
      show-show-apps-button = false;
    };

    "org/gnome/shell/extensions/EasyScreenCast" = {
      file-container = 1;
      fps = 60;
      quality-index = 3;
    };

    "org/gnome/shell/extensions/hidetopbar" = {
      mouse-sensitive = true;
    };

    "org/gnome/shell/extensions/lilypad" = {
      lilypad-order = ["ForceQuitButton" "EasyScreenCast_indicator" "color_picker" "clipqr" "clipboardIndicator" "keyboard"];
      rightbox-order = ["lilypad"];
    };
  };
}