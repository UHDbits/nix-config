# Nix module to enable Secure Boot on UEFI systems.
###############################################################
# Before using this module, make sure the system is prepared using the directions at:
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
{ inputs, lib, ... }:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  # Disable systemd-boot as Lanzaboote replaces it.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable Lanzaboote and set key location.
  boot.lanzaboote = {
    enable = lib.mkForce true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Impermanence
  /*
    environment.persistence = {
      "/persist".directories = ["/var/lib/sbctl"];
    };
  */
}
