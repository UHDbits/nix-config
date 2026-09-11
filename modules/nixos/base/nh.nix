# Nix configuration file to setup nh (nix helper).
{ username, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${username}/Git Repositories/nix-config";
  };
}
