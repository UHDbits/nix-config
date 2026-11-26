{ pkgs, ... }:
{
  # Installs the package and a capability wrapper so KMS capture works
  # without running as root.
  programs.gpu-screen-recorder.enable = true;

  # Region selection for gpu-screen-recorder's `-w region`.
  environment.systemPackages = [ pkgs.slurp ];
}
