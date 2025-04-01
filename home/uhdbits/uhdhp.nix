# Nix configuration file for home-manager on my HP ProBook 445 G9.
{
  imports = [
    # Imports for all home-manager features on this machine.
    ./global.nix
    ./features/desktop/programs/chromium.nix
    ./features/desktop/programs/firefox.nix
    ./features/desktop/gnome
    ./features/development/frc.nix
    ./features/development/vscode.nix
    ./features/development/java
  ];
}
