# Nix configuration file for general GNOME and GNOME app settings.
{ lib, pkgs, ... }:
with lib.hm.gvariant;
{
  # Configure GTK theming and configuration.
  gtk = {
    enable = true;
    
    gtk3 = {
      enable = true;
      theme = {
        name = lib.mkDefault "adw-gtk3-dark";
        package = lib.mkDefault pkgs.adw-gtk3;
      };
    };
  };

  # Configure dconf settings.
  dconf.settings = with lib.hm.gvariant; {
    ## App Folders ##
    "org/gnome/desktop/app-folders" = {
      # Finish adding app folders
      folder-children = [ "System" "Utilities" "FRC" ];
    };

    "org/gnome/desktop/app-folders/folders/FRC" = {
      apps = [ "advantagescope.desktop" "choreo.desktop" "DataLogTool.desktop" "elastic-dashboard.desktop" "Glass.desktop" "OutlineViewer.desktop" "pathplanner.desktop" "roboRIOTeamNumberSetter.desktop" "SysId.desktop" "wpical.desktop" ];
      name = "FRC";
      translate = false;
    };

    ## General GNOME settings ##
    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
        (mkTuple [
          "xkb"
          "us+colemak"
        ])
      ];
    };

    "org/gnome/desktop/file-sharing" = {
      require-password = true;
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/mutter" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
    };

    "org/gnome/screensaver" = {
      lock-delay = 0;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = mkDouble 21.0;
      night-light-schedule-to = mkDouble 6.0;
      night-light-temperature = mkUint32 2700;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
      power-button-action = "suspend";
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-ac-timeout = 1200;
    };

    "org/gnome/shell" = {
      # Finish
      favorite-apps = [ "firefox.desktop" "code.desktop" "org.gnome.Nautilus.desktop" ];
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/keybindings" = {
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = false;
      locations = [ (mkVariant (mkTuple [ (mkUint32 2) (mkVariant (mkTuple [ "Phoenix" "KPHX" true [ (mkTuple [ (mkDouble "0.583536296811635") (mkDouble "-1.955660817467636") ]) ] [ (mkTuple [ (mkDouble "0.5837843080983434") (mkDouble "-1.9560609516519483") ]) ] ])) ])) ];
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    ## App Settings ##
    "org/gnome/Console" = {
      ignore-scrollback-limit = true;
    };

    "org/gnome/Weather" = {
      locations = [ (mkVariant (mkTuple [ (mkUint32 2) (mkVariant (mkTuple [ "Phoenix" "KPHX" true [ (mkTuple [ (mkDouble "0.583536296811635") (mkDouble "-1.955660817467636") ]) ] [ (mkTuple [ (mkDouble "0.5837843080983434") (mkDouble "-1.9560609516519483") ]) ] ])) ])) ];
    };
  };
}
