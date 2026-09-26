{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.desktop == "niri") {
    environment.systemPackages = with pkgs; [
      ghostty
      nautilus
    ];

    programs.niri.enable = true;
    services.displayManager.gdm.enable = true;
  };
}
