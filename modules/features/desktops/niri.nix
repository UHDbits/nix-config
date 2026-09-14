{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.desktop == "niri") {
    programs.niri.enable = true;
    services.displayManager.gdm.enable = true;
  };
}
