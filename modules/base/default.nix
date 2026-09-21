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

  hardware.enableRedistributableFirmware = true;

  i18n.defaultLocale = "en_US.UTF-8";
  services.fstrim.enable = true;
  time.timeZone = "America/Phoenix";
}
