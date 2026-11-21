{
  inputs,
  lib,
  pkgs,
  ...
}:
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
      # Panel Replay hangs the display firmware after some resumes (cursor moves freeze the screen).
      "amdgpu.dcdebugmask=0x400"
      "nmi_watchdog=0"
    ];
  };
  hardware = {
    amdgpu.initrd.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault true;
    sensor.iio.enable = true;
  };

  # ACPI processor cooling stores cpuinfo_max_freq as a frequency cap. A thermal update while
  # power-saver has boost off (e.g. on resume) pins every core at the 3 GHz base clock after
  # boost returns. Rewriting the current cooling state on profile changes recomputes the cap.
  systemd.services.cpu-thermal-limit-refresh = {
    after = [ "power-profiles-daemon.service" ];
    description = "Recompute ACPI processor thermal frequency limits";
    script = ''
      # One Processor device recomputes the limit for every CPU in the package.
      dev=$(grep -lx Processor /sys/class/thermal/cooling_device*/type | head -n 1)
      dev=''${dev%/type}
      refresh() {
        read -r state < "$dev/cur_state"
        echo "$state" > "$dev/cur_state"
      }
      refresh
      ${lib.getExe' pkgs.glib "gdbus"} monitor --system \
        --dest org.freedesktop.UPower.PowerProfiles \
        --object-path /org/freedesktop/UPower/PowerProfiles |
        while read -r _; do refresh; done
    '';
    serviceConfig.Restart = "always";
    wantedBy = [ "multi-user.target" ];
  };
}
