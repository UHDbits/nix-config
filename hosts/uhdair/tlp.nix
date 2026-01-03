# Nix module to set tlp settings for the MBA.
{
  services.tlp.settings = {
    # Audio power settings.
    #############################################
    SOUND_POWER_SAVE_ON_AC = 1;
    SOUND_POWER_SAVE_ON_BAT = 1;
    #############################################

    # Disk power settings.
    #############################################
    SATA_LINKPWR_ON_AC = "min_power";
    SATA_LINKPWR_ON_BAT = "min_power";
    #############################################

    # Platform power settings.
    #############################################
    PLATFORM_PROFILE_ON_AC = "performance";
    PLATFORM_PROFILE_ON_BAT = "low-power";

    # MEM_SLEEP_ON_AC=s2idle
    # MEM_SLEEP_ON_BAT=s2idle
    #############################################

    # CPU power settings.
    #############################################
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "balance-power";
    #############################################

    # Radio device power settings.
    #############################################
    DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
    #############################################

    # PCIE power settings.
    #############################################
    PCIE_ASPM_ON_AC = "default";
    PCIE_ASPM_ON_BAT = "powersupersave";
    #############################################
  };
}
