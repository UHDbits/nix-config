# Nix configuration file to setup basic sound settings.
{
  # Make sure PulseAudio is not enabled, as it conflicts with PipeWire.
  hardware.pulseaudio.enable = false;

  # Enable the RealtimeKit system service.
  security.rtkit.enable = true;

  # Set PipeWire settings.
  services.pipewire = {
    # Enable PipeWire.
    enable = true;

    # Enable ALSA support.
    alsa.enable = true;
    alsa.support32Bit = true;

    # Enable JACK emulation.
    jack.enable = true;

    # Enable PulseAudio emulation.
    pulse.enable = true;

    # Enable WirePlumber.
    wireplumber.enable = true;
  };
}
