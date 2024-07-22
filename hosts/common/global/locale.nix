# Nix configuration file to set locale settings.
{
  # Set time settings.
  time = {
    # Set my time zone.
    timeZone = "America/Phoenix";

    # Set hardware clock to be stored in local time to ensure compatibility with Windows.
    hardwareClockInLocalTime = true;
  };
  
  # Select internationalisation properties.
  i18n = {
    # Set the default locale of the system.
    defaultLocale = "en_US.UTF-8";

    # Set any additional locale settings.
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

}
