# Nix configuration file for home-manager on my HP ProBook 445 G9.
{
  imports = [
    # Imports for all home-manager features on this machine.
    ./global.nix
    ./features/desktop/programs/chromium.nix
    ./features/desktop/programs/floorp.nix
    ./features/desktop/warp.nix
    # ./features/development/frc.nix
  ];
}
