{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    inputs.codex-desktop-linux.homeManagerModules.default
    inputs.helium.homeModules.default
  ];

  home.packages = [
    inputs.claude-desktop-extra.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.cine
    pkgs.gitte
    pkgs.loupe
  ]
  ++ lib.optionals (osConfig.desktop == "niri") [
    pkgs.adwaita-icon-theme
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
    t3code = {
      enable = true;
      package = pkgs.t3code.override { enableClaude = true; };
    };
    thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = { };
      };
    };
  };

  wayland.windowManager.niri = lib.mkIf (osConfig.desktop == "niri") {
    enable = true;
    enableDefaultConfig = true;
    extraConfig = ''
      include optional=true "${config.xdg.configHome}/niri/noctalia.kdl"
    '';
  };
}
