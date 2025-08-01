# Nix configuration file to setup general security settings.
{ lib, ... }:
{
  security.protectKernelImage = lib.mkDefault true;
  security.audit.enable = true;
  security.auditd.enable = true;
}