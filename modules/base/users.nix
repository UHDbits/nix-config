# Nix configuration file to setup the standard user account.
{ pkgs, ... }:
{
  users.users.uhdbits = {
    description = "Ashton A.";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    initialPassword = "initial";
    shell = pkgs.fish;
  };
}
