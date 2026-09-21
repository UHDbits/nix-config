{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
      "usb_storage"
      "xhci_pci"
    ];
    initrd.kernelModules = [
      "t2bce_audio"
      "t2bce_core"
      "t2bce_vhci"
    ];
    kernelParams = [
      "i915.enable_guc=2"
      "intel_iommu=on"
      "iommu=pt"
      "mem_sleep_default=s2idle"
      "pcie_aspm=off"
      "pcie_ports=compat"
      "pm_async=off"
    ];
  };
  systemd.sleep.settings.Sleep.SuspendState = "freeze";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault true;
    firmware = [
      (pkgs.stdenvNoCC.mkDerivation {
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/lib/firmware/brcm
          tar -xf $src -C $out/lib/firmware/brcm
        '';
        name = "uhdair-brcm-firmware";
        src = ./firmware.tar.gz;
      })
    ];
  };
}
