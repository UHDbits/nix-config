# Nix configuration file to install FRC related packages.
{ pkgs, inputs, ... }:
{
  # Install packages for FRC.
  home.packages = [
    # WPILib Packages
    pkgs.wpilib.datalogtool
    pkgs.wpilib.glass
    pkgs.wpilib.outlineviewer
    pkgs.wpilib.roborioteamnumbersetter
    pkgs.wpilib.sysid
    pkgs.wpilib.wpilib-utility

    # AdvantageScope (log viewing utility)
    pkgs.advantagescope

    # Choreo and PathPlanner (Pathplanning Utilities)
    pkgs.choreo
    pkgs.pathplanner

    # Elastic Dashboard
    pkgs.elastic-dashboard
  ];

  # Add WPILib VS Code extension.
  programs.vscode.extensions = [ pkgs.wpilib.vscode-extension ];
}
