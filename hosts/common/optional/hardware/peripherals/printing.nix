# Nix configuration file for printing support.
{lib, pkgs, ...}:
{
  # Configure normal printing settings.
  services.printing = {
    drivers = lib.mkDefault [ pkgs.hplipWithPlugin ];
    enable = lib.mkForce true;
    webInterface = lib.mkDefault false;
  };

  # Enable the IPP everywhere protocol.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}