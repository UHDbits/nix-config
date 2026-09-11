# NixOS configuration file for Intel GPUs.
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.common-gpu-intel
  ];

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = lib.mkDefault "iHD";
  };
}
