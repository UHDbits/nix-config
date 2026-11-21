{
  config,
  lib,
  pkgs,
  ...
}:
let
  keyboard = action: [
    "systemctl"
    "--user"
    action
    "wvkbd.service"
  ];
in
{
  config = lib.mkIf (config.desktop == "niri") {
    home-manager.users.uhdbits = {
      # Chromium only reports focused text fields to Niri's text-input-v3 with these.
      programs.helium.flags = [
        "--enable-wayland-ime"
        "--wayland-text-input-version=3"
      ];

      # Runs only in tablet mode; --auto shows it while a text field has focus.
      systemd.user.services.wvkbd = {
        Service.ExecStart = "${lib.getExe pkgs.wvkbd} ${
          lib.escapeShellArgs [
            "--auto"
            "--hidden"
            "--fn"
            "Sans 18"
            "-H"
            "450"
            "-L"
            "360"
          ]
        }";
        Unit = {
          After = [ "graphical-session.target" ];
          Description = "wvkbd on-screen keyboard";
          PartOf = [ "graphical-session.target" ];
        };
      };

      wayland.windowManager.niri.settings.switch-events = {
        tablet-mode-off.spawn = keyboard "stop";
        tablet-mode-on.spawn = keyboard "start";
      };
    };

    # Without --monitor, iio-niri rotates whichever output Niri lists first.
    services.iio-niri = {
      enable = true;
      extraArgs = [
        "--monitor"
        "eDP-1"
      ];
    };
  };
}
