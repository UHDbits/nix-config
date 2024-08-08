# Nix configuration file to set keyboard layout settings.
{ lib, ... }:
with lib.hm.gvariant;
{
  # Set the keyboard layout settings for GNOME.
  dconf.settings = {
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
  };
}
