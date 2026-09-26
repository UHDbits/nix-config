{ inputs, ... }:
{
  imports = [ inputs.z13helper.nixosModules.default ];

  hardware.cpu.amd.ryzen-smu.enable = true;

  services.z13helperd = {
    enable = true;
    settings = {
      batteryLimit = 100;
      lighting = {
        keyboard.enable = false;
        lightbar.enable = false;
      };
    };
    users = [ "uhdbits" ];
  };

  home-manager.users.uhdbits = {
    imports = [ inputs.z13helper.homeModules.default ];
    programs.z13helper = {
      enable = true;
      systemd.enable = true;
    };
  };
}
