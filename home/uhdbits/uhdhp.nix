# Nix configuration file for home-manager on my HP ProBook 445 G9.
{
  imports = [
    # Imports for all home-manager features on this machine.
    ./global.nix
    ./features/desktop/chromium.nix
  ];
}
