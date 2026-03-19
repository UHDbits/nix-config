# NixOS configuration file for AMD GPUs.
{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.common-gpu-amd
  ];

  hardware.amdgpu.opencl.enable = true;
}
