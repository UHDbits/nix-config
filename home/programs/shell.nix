{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-index-database.homeModules.default ];

  programs = {
    claude-code.enable = true;
    fish.enable = true;
    gh.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          email = "uhdbits@duck.com";
          name = "Ashton A.";
        };
      };
        # pins it, since the primary secret key is kept offline.
    };
    gpg.enable = true;
    nix-index.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
