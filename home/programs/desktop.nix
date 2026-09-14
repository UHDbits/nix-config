{
  inputs,
  lib,
  osConfig,
  ...
}:
{
  imports = [
    inputs.codex-desktop-linux.homeManagerModules.default
    inputs.helium.homeModules.default
    inputs.noctalia.homeModules.default
  ];

  programs = {
    codexDesktopLinux.enable = true;
    helium = {
      enable = true;
      flags = [ "--ozone-platform-hint=auto" ];
    };
    noctalia = lib.mkIf (osConfig.desktop == "niri") {
      enable = true;
      systemd.enable = true;
    };
    thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = { };
      };
    };
  };
}
