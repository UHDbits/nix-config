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

    # Desktop interface configuration
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/session" = {
      idle-delay = 600;
    }

    "org/gnome/desktop/sound" = {
      event-sounds = false;
    };

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
