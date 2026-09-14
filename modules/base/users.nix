{
  inputs,
  pkgs,
  scanPaths,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs scanPaths; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.uhdbits = import ../../home/uhdbits.nix;
  };

  users = {
    mutableUsers = false;

    users.uhdbits = {
      description = "Ashton A.";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      hashedPasswordFile = "/persist/secrets/userpassword";
      isNormalUser = true;
      shell = pkgs.fish;
    };
  };
}
