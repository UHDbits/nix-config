{ lib, scanPaths, ... }:
{
  imports = scanPaths ./.;

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
