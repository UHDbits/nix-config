# NixOS configuration file for my Intel MacBook Air 2020.
{ lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    ../../modules/nixos/defaults/fulldesktop.nix
  ];

  networking.hostName = "uhdair";
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  programs.fish.enable = true;
  programs.git.enable = true;
  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    antigravity
    zed-editor
    gitkraken
  ];

  # Fan control service
  services.t2fanrd = {
    enable = true;
    config.Fan1.always_full_speed = true;
  };

  # WiFi/BT firmware
  hardware.firmware = [
      (pkgs.stdenvNoCC.mkDerivation (final: {
        name = "brcm-firmware";
        src = ./firmware.tar.gz;

        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/lib/firmware/brcm
          tar -xf ${final.src} -C $out/lib/firmware/brcm
        '';
      }))
    ];

  # Kernel parameters to fix suspend
  boot.kernelParams = [
    "i915.enable_guc=2"
    "intel_iommu=on"
    "iommu=pt"
    "mem_sleep_default=s2idle"
    "pcie_aspm=off"
    "pcie_ports=compat"
  ];

  systemd.sleep.settings.Sleep = {
    SuspendState = "freeze";
  };

  # temp boot config
  boot.loader.systemd-boot = {
      enable = true;

      configurationLimit = lib.mkDefault 5;
      editor = lib.mkDefault false;
    };

  # temp kernel config
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;
}
