{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-index-database.homeModules.default ];

  programs = {
    fish.enable = true;
    git.enable = true;
    gpg.enable = true;
    nix-index.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
