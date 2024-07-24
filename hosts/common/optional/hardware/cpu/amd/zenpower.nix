# Nix configuration file to enable the zenpower sensor.
{ config, ... }:
{
  # Enables the zenpower sensor in lieu of the k10temp sensor on Zen CPUs https://git.exozy.me/a/zenpower3
  # On Zen CPUs, zenpower produces much more data entries.
  boot = {
    # Prevent the normal temperature sensor from loading.
    blacklistedKernelModules = [ "k10temp" ];
    # Add the zenpower package.
    extraModulePackages = [ config.boot.kernelPackages.zenpower ];
    # Add the zenpower module.
    kernelModules = [ "zenpower" ];
  };
}
