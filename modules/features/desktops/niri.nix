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
      xwayland-satellite
    ];

    programs.niri.enable = true;
    services.displayManager.gdm.enable = true;
  };
}
