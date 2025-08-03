# Nix configuration file to enable various TPM2 features.
{ lib, ... }:
{
  security.tpm2 = {
    enable = true;
    pkcs11.enable = lib.mkDefault true;
    tctiEnvironment.enable = lib.mkDefault true;
  };

  systemd.tpm2.enable = lib.mkDefault true;
}