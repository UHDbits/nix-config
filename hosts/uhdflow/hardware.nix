{ inputs, lib, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
      "usb_storage"
      "xhci_pci"
    ];
    kernelParams = [ "amd_pstate=active" ];
  };
  hardware = {
    amdgpu.initrd.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault true;
    sensor.iio.enable = true;
  };
}
