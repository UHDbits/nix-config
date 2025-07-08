# Nix configuration file to set tlp settings for the ProBook.
{
  services.tlp.settings = {
    # Audio power settings.
    #############################################
    SOUND_POWER_SAVE_ON_AC = 0;
    SOUND_POWER_SAVE_ON_BAT = 1;
    #############################################

    # SSD power settings.
    #############################################
    DISK_IOSCHED = "mq-deadline mq-deadline";

    SATA_LINKPWR_ON_AC = "min_power";
    SATA_LINKPWR_ON_BAT = "min_power";
    #############################################

    # Graphics power settings.
    #############################################
    RADEON_DPM_PERF_LEVEL_ON_AC = "high";
    RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

    RADEON_DPM_STATE_ON_AC = "performance";
    RADEON_DPM_STATE_ON_BAT = "battery";
    #############################################

    # Platform power settings.
    #############################################
    PLATFORM_PROFILE_ON_AC = "performance";
    PLATFORM_PROFILE_ON_BAT = "low-power";
    #############################################

    # CPU power settings.
    #############################################
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_SCALING_MIN_FREQ_ON_AC = 0;
    CPU_SCALING_MAX_FREQ_ON_AC = 9999999;
    CPU_SCALING_MIN_FREQ_ON_BAT = 0;
    CPU_SCALING_MAX_FREQ_ON_BAT = 9999999;

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "balance-power";

    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 1;
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
