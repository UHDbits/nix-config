# Nix configuration file to enable AppImage support.
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}