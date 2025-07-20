# Nix configuration file for printing support.
{lib, pkgs, ...}:
{
  services.printing = {
    cups-pdf.instances.pdf.settings = { 
      Out = "\${HOME}/Downloads";
    };
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