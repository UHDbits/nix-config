# NixOS configuration file for Nvidia GPUs.
{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-hardware.common-gpu-nvidia ];

  hardware.graphics.extraPackages = with pkgs; [
    libva-vdpau-driver
    libvdpau-va-gl
  ];

  hardware.nvidia.modesetting = true;
}
