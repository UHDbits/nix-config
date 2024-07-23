# Nix configuration file to set general settings for AMD GPUs.
{ lib, ... }:

{
  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

  hardware.opengl = {
    enable = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };

  hardware.amdgpu.initrd.enable = lib.mkDefault true;
}