{ lib, scanPaths, ... }:
{
  imports = scanPaths ./.;

  options.desktop = lib.mkOption {
    type = lib.types.enum [
      "cosmic"
      "gnome"
      "niri"
    ];
    default = "cosmic";
    description = "Desktop session offered by the display manager.";
  };
}
