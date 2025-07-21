# Nix configuration file to setup my main user, uhdbits.
{
  pkgs,
  ...
}:
{
  # Configure the basic user settings.
  users.users.uhdbits = {
    description = "Ashton A.";
    extraGroups = [ "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}