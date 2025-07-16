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
    };

    # Geolocation settings (just disable)
    "org/gnome/system/location" = {
      enabled = false;
    };
  };
}
