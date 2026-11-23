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
      signing = {
        format = "openpgp";
        key = "6FF16354F61EC5C24AD17FBB77F2498613EE2059!";
        signByDefault = true;
      };
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
