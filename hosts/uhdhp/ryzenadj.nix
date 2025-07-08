# Nix configuration file to set RyzenAdj settings for the ProBook.
{ pkgs, ... }:
let
  # These values will be set if the computer is on AC power (plugged in).
  stapm-limit-ac = 30001;
  fast-limit-ac = 30001;
  slow-limit-ac = 25001;
  slow-time-ac = 30;
  stapm-time-ac = 1;
  apu-skin-temp-ac = 95;

  # These values will be set if the computer is on battery power (unplugged).
  stapm-limit-bat = 15000;
  fast-limit-bat = 20000;
  slow-limit-bat = 15000;
  slow-time-bat = 5;
  stapm-time-bat = 1;
  apu-skin-temp-bat = 45;

  # Create commands to run on AC and battery.
  # We run ryzenadj twice, one to set the power-saving/max-performance, and again to set our custom settings, to prevent power-saving/max-performance from overwriting any of our settings (mainly slow-time).
  ryzenadj-ac-command = "${pkgs.ryzenadj}/bin/ryzenadj --max-performance --stapm-limit=${toString stapm-limit-ac} --fast-limit=${toString fast-limit-ac} --slow-limit=${toString slow-limit-ac} --slow-time=${toString slow-time-ac} --stapm-time=${toString stapm-time-ac} --apu-skin-temp=${toString apu-skin-temp-ac}";
  ryzenadj-bat-command = "${pkgs.ryzenadj}/bin/ryzenadj --power-saving --stapm-limit=${toString stapm-limit-bat} --fast-limit=${toString fast-limit-bat} --slow-limit=${toString slow-limit-bat} --slow-time=${toString slow-time-bat} --stapm-time=${toString stapm-time-bat} --apu-skin-temp=${toString apu-skin-temp-bat}";

  # Create udev rules to run when switching between AC power or battery power.
  ryzenadj-udev = pkgs.writeTextFile {
    name = "60-ryzenadj.rules";
    text = ''
      SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${ryzenadj-ac-command}"
      SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${ryzenadj-bat-command}"
    '';
    destination = "/etc/udev/rules.d/60-ryzenadj.rules";
  };
in
{
  # Enable "ryzen-smc" to prevent accessing /dev/mem.
  hardware.cpu.amd.ryzen-smu.enable = true;

  # Add "ryzenadj" to the system packages list.
  environment.systemPackages = [ pkgs.ryzenadj ];

  # Add the "60-ryzenadj.rules" file to the udev packages.
  services.udev.packages = [ ryzenadj-udev ];
}
