{
  lib,
  pkgs,
  scanPaths,
  ...
}:
{
  imports = scanPaths ./.;

  config.fonts = {
    packages = [
      pkgs.adwaita-fonts
      pkgs.inter
    ];
    fontconfig.defaultFonts.sansSerif = [ "Adwaita Sans" ];
  };

  options.desktop = lib.mkOption {
    default = "cosmic";
    description = "Desktop session offered by the display manager.";
    type = lib.types.enum [
      "cosmic"
      "gnome"
      "niri"
    ];
  };
}
