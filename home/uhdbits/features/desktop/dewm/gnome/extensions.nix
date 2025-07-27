{ lib, pkgs, ... }:
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
    pkgs.gnomeExtensions.lilypad # Configure
    pkgs.gnomeExtensions.pip-on-top
    pkgs.gnomeExtensions.quick-settings-audio-devices-renamer # Finish configuration
    pkgs.gnomeExtensions.quick-settings-audio-panel
    pkgs.gnomeExtensions.rectangle
    pkgs.gnomeExtensions.solaar-extension
    pkgs.gnomeExtensions.tiling-shell # Enabled, configure settings
  ];

  # Settings for extensions.
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell" = {
      enabled-extensions = lib.mkDefault [
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
        "clipboard-indicator@tudmotu.com"
        "clipqr@drien.com"
        "color-picker@tuberry"
        "custom-command-toggle@storageb.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "EasyScreenCast@iacopodeenosee.gmail.com"
        "flickernaut@imoize.github.io"
        "fq@megh"
        "gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com"
        "lilypad@shendrew.github.io"
        "quicksettings-audio-devices-renamer@marcinjahn.com"
        "pip-on-top@rafostar.github.com"
        "quick-settings-audio-panel@rayzeq.github.io"
        "rectangle@acristoffers.me"
        "solaar-extension@sidevesh"
        "tilingshell@ferrarodomenico.com"
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
      compatibility = false; 
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      static-blur = false;
      unblur-in-overview = false;
    };

    "org/gnome/shell/extensions/caffeine" = {
      enable-fullscreen = false;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      always-center-icons = true;
      apply-custom-theme = false;
      dash-max-icon-size = 42;
      extend-height = true;
      hot-keys = false;
      intellihide-mode = "ALL_WINDOWS";
    };

    "org/gnome/shell/extensions/EasyScreenCast" = {
      file-container = 1;
      fps = 60;
      quality-index = 3;
    };

    "org/gnome/shell/extensions/hidetopbar" = {
      enable-active-window = false;
      mouse-sensitive = true;
    };

    "org/gnome/shell/extensions/lilypad" = {
      lilypad-order = ["ForceQuitButton" "EasyScreenCast_indicator" "color_picker" "clipqr" "clipboardIndicator" "Rectangle" "tilingshell" "keyboard"];
      rightbox-order = ["lilypad"];
    };

    "org/gnome/shell/extensions/tilingshell" = {
      enable-screen-edges-windows-suggestions = false;
      enable-snap-assistant-windows-suggestions = true;
      enable-tiling-system = false;
      inner-gaps = mkUint32 8;
      outer-gaps = mkUint32 8;
      quarter-tiling-threshold = mkUint32 30;
      show-indicator = false;
      top-edge-maximize = true;
    };
  };
}