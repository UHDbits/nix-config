# NixOS configuration file for AMD GPUs.
{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.common-gpu-amd
  ];

  hardware.graphics.extraPackages = [ pkgs.rocmPackages.clr.icd ];
}
