{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    initrd.availableKernelModules = [ "usb_storage" ];
    kernelParams = [
      "amd_pstate=active"
      "nmi_watchdog=0"
    ];
  };
  hardware.sensor.iio.enable = true;
}
