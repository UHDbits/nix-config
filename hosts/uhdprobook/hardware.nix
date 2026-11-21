{ inputs, ... }:
{
  # HP ProBook 445 G9: Ryzen 7 5825U (Barcelo), Realtek ALC236, Qualcomm
  # WCN6855 (ath11k) Wi-Fi/Bluetooth, Realtek RTL8111 Ethernet.
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    initrd.availableKernelModules = [ "usb_storage" ];
    kernelParams = [ "nmi_watchdog=0" ];
  };
}
