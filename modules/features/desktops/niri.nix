{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.noctalia.nixosModules.default ];

  config = lib.mkIf (config.desktop == "niri") {
    programs.niri.enable = true;
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      recommendedServices.enable = true;
    };
    services.displayManager.gdm.enable = true;
  };
}
