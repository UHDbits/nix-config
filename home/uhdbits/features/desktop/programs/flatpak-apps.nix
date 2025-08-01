# Home Manager configuration file to enable and setup flatpak apps.
{ inputs, lib, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "com.bambulab.BambuStudio"
  ];
}