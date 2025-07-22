# Nix configuration file to set and enable Chromium settings with home-manager.
{
  # Set Chromium home-manager settings.
  programs.chromium = {
    # Enable the browser.
    enable = true;

    # Enable specific command-line arguments for Chromium.
    commandLineArgs = [
      # Enable Wayland.
      "--ozone-platform-hint=auto"
      # Force GTK4.
      "--gtk-version=4"
    ];
  };
}
