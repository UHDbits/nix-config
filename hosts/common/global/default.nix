{ pkgs, ... }:
{
  imports = [
    ./locale.nix
    ./users/uhdbits/default.nix
  ];
}
