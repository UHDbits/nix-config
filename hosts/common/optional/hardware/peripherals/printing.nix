# Nix configuration file for printing support.
{
  services.printing.enable = true;

  # Enable the IPP everywhere protocol.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}