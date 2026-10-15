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
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings.default_session.command =
        "${lib.getExe pkgs.tuigreet} --time --cmd ${lib.getExe' config.programs.niri.package "niri-session"}";
    };
  };
}
