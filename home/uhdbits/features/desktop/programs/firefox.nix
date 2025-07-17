# Nix configuration file to set and enable Floorp (Firefox fork) settings with home-manager.
{ ... }:
{
  # Set Firefox (Floorp) settings.
  programs.firefox = {
    # Enable the browser.
    enable = true;

    profiles.uhdbits = {
      settings = {
        "browser.startup.homepage" = "google.com";
      };
    };
  };
}
