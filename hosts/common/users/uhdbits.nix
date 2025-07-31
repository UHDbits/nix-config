# Nix configuration file to setup my main user, uhdbits.
{ pkgs, ... }:
{
  users.users.uhdbits = {
    description = "Ashton A.";
    extraGroups = [ "wheel" ];
    initialPassword = "changechangechangechangechangechangechangechangechangechange";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}