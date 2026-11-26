{ pkgs, ... }:
{
  # Region selection for gpu-screen-recorder's `-w region`.
  environment.systemPackages = [ pkgs.slurp ];

  programs = {
    fish.enable = true;
    # Installs the package and capability wrapper so KMS capture works without root.
    gpu-screen-recorder.enable = true;
    nh = {
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
      enable = true;
    };
  };

  services.flatpak.enable = true;
}
