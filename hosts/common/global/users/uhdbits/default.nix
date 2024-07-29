# Nix configuration file to setup my main user, uhdbits.
{ pkgs, lib, ... }:
{
  # Configure the basic user settings.
  users.users.uhdbits = {
    # Set the description (full name) of the user.
    description = "Ashton A.";

    # Set the extra groups of the user.
    extraGroups = [ "wheel" ];

    # Set the user as a normal user.
    isNormalUser = true;

    # Add specific pacakges for the user (this will be changed soon).
    packages = [
      pkgs.gitkraken
      pkgs.vscode
    ];

    # Set a temporary password for the user (this will be changed soon).
    initialPassword = "password";

    # Set the default shell of the user.
    shell = pkgs.fish;
  };
}
