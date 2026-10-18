{ inputs, ... }:
{
  imports = [ inputs.z13helper.nixosModules.default ];

  # z13helperd restores the last applied profile from its state file at boot.
  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/z13helper";
      group = "z13helper";
      mode = "0750";
      user = "root";
    }
  ];

  hardware.cpu.amd.ryzen-smu.enable = true;

  home-manager.users.uhdbits = {
    imports = [ inputs.z13helper.homeModules.default ];
    programs.z13helper = {
      enable = true;
      systemd.enable = true;
    };
  };

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
}
