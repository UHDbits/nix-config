# Nix configuration package to install VS Code.
{ pkgs, ... }:
{
  programs.vscode = {
    package = pkgs.vscode.fhs;
    enable = true;
  };
}
