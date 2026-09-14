{ pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.uhdbits = import ../../home/uhdbits.nix;
  };

  users.users.uhdbits = {
    description = "Ashton A.";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = "/persist/secrets/userpassword";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
