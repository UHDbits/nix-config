# Nix configuration file to set AMD CPU scaling settings.
{ config, lib, ... }:
let
  # Get the kernel version.
  kver = config.boot.kernelPackages.kernel.version;
in
{
  # Enables the AMD CPU scaling. https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
  # On recent AMD CPUs this can be more energy efficient.

  imports = [ ./. ];
  boot = lib.mkMerge [
    (lib.mkIf ((lib.versionAtLeast kver "5.17") && (lib.versionOlder kver "6.1")) {
      kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];
      kernelModules = [ "amd-pstate" ];
    })
    (lib.mkIf ((lib.versionAtLeast kver "6.1") && (lib.versionOlder kver "6.3")) {
      kernelParams = [ "amd_pstate=passive" ];
    })
    (lib.mkIf (lib.versionAtLeast kver "6.3") { kernelParams = [ "amd_pstate=active" ]; })
  ];
}
