# Nix configuration file to enable various TPM2 features.
{
  systemd.tpm2.enable = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;
}