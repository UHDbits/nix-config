# Nix configuration file to set and enable Chromium settings.
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  # Set Chromium home-manager settings.
  programs.chromium = {
    # Enable the browser.
    enable = true;

    # Set the Chromium package to Brave.
    package = pkgs.brave;
  };
}
