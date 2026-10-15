{
  inputs,
  scanPaths,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
  ]
  ++ scanPaths ./.
  ++ scanPaths ../features;

  environment.sessionVariables.SYSTEMD_LOG_LEVEL = "err";

  hardware.enableRedistributableFirmware = true;

  i18n.defaultLocale = "en_US.UTF-8";
  services.fstrim.enable = true;
  time.timeZone = "America/Phoenix";
}
