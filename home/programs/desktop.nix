{ inputs, pkgs, ... }:
{
  imports = [
    inputs.codex-desktop-linux.homeManagerModules.default
    inputs.helium.homeModules.default
  ];

  home.packages = [
    inputs.claude-desktop-extra.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.antigravity-acp
    pkgs.cine
    pkgs.gitte
    pkgs.loupe
  ];

  programs = {
    codexDesktopLinux.enable = true;
    ghostty = {
      enable = true;
      enableFishIntegration = true;
    };
    helium = {
      enable = true;
      flags = [ "--ozone-platform-hint=auto" ];
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
    zed-editor.enable = true;
  };
}
