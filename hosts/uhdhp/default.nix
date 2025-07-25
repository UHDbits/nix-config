# NixOS configuration file for my HP ProBook 445 G9.
{
  lib,
  modulesPath,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    ./filesystem.nix
    ./ryzenadj.nix
    ./tlp.nix
    ../common/global
    ../common/optional/features/fish.nix
    ../common/optional/features/flatpak.nix
    ../common/optional/features/desktop/chromium.nix
    ../common/optional/features/desktop/warp.nix
    ../common/optional/features/desktop/gnome.nix

    # Common hardware imports to improve AMD CPU/GPU support.
    ../common/optional/hardware/cpu/amd
    ../common/optional/hardware/cpu/amd/pstate.nix
    ../common/optional/hardware/cpu/amd/zenpower.nix
    ../common/optional/hardware/gpu/amd

    # Common TLP imports in order to make sure TLP functions.
    ../common/optional/hardware/laptop/tlp.nix

    # Other miscellaneous common hardware related imports.
    ../common/optional/hardware/sound
    ../common/optional/hardware/ssd
    ../common/optional/hardware/peripherals/fingerprint.nix
    ../common/optional/hardware/peripherals/printing.nix

    # Common UEFI imports to customize the bootloader and enable secure boot.
    ../common/optional/boot/systemd-boot.nix
    ../common/optional/boot/secureboot.nix

    inputs.home-manager.nixosModules.home-manager
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Encrypted partition
  #boot.initrd.luks.devices = {
  #  root = {
  #    device = "/dev/nvme0n1p3";
  #    preLVM = true;
  #  };
  #};

  # TODO: Set your hostname
  networking.hostName = "uhdhp";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Install GnuPG
  programs.gnupg.agent.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs pkgs;
    };
    users = {
      uhdbits = import ../../home/uhdbits/uhdhp.nix;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  hardware.i2c.enable = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so  
  security.tpm2.tctiEnvironment.enable = true;
  services.fwupd.enable = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
