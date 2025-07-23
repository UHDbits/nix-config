# Nix configuration file for general GNOME settings.
{ lib, ... }:
with lib.hm.gvariant;
{
  dconf.settings = {
    # Input sources/keymap configuration
    "org/gnome/desktop/input-sources" = {
      sources = [
        # Normal US layout.
        (mkTuple [
          "xkb"
          "us"
        ])
        # US Colemak layout.
        (mkTuple [
          "xkb"
          "us+colemak"
        ])
      ];
    };

    "org/gnome/desktop/file-sharing" = {
      require-password = true;
    };

    # Desktop interface configuration
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      locate-pointer = true;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
    }

    "org/gnome/desktop/session" = {
      idle-delay = 300;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
    };

    "org/gnome/screensaver" = {
      lock-delay = 0;
    }

    # Night light configuration
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 20;
      night-light-schedule-to = 6;
      night-light-temperature = 2700;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
      power-button-action = "suspend";
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-ac-timeout = 1200;
    };

    # Geolocation settings (just disable)
    "org/gnome/system/location" = {
      enabled = false;
    };
  };
}
