# NixOS configuration file for VDPAU/VAAPI.
{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.common-gpu-amd
  ];

  # Add a few extra AMD graphics patches
  hardware.graphics.extraPackages = with pkgs; [
    libva-vdpau-driver
    libvdpau-va-gl
  ];
}
