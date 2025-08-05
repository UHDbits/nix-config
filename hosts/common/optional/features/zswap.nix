# Nix configuration file to setup zswap.
{ lib, ... }:
{
  # Add lz4 for the default compressor.
  boot.initrd.availableKernelModules = [ "lz4" ];
  boot.initrd.systemd.enable = true;
  
  boot.kernel.sysctl = {
    "vm.swappiness" = lib.mkDefault 15;
  };
  
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=lz4"
    "zswap.max_pool_percent=50"
  ];
}