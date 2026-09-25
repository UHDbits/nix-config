{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-index-database.homeModules.default ];

  programs = {
    fish.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          email = "uhdbits@duck.com";
          name = "Ashton A.";
        };
      };
    };
    gpg.enable = true;
    gh.enable = true;
    nix-index.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
