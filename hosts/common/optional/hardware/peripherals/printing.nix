# Nix configuration file for printing support.
{lib, pkgs, ...}:
{
  services.printing = {
    cups-pdf.instances.pdf.settings = { 
      Out = "\${HOME}/Downloads";
      UserUMask = "0033";
    };
    drivers = lib.mkForce [ pkgs.hplipWithPlugin ];
    enable = lib.mkForce true;
    webInterface = lib.mkForce false;
  };

  # Enable the IPP everywhere protocol.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}