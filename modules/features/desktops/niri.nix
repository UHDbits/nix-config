{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.desktop == "niri") {
    environment.systemPackages = with pkgs; [
      ghostty
      nautilus
    ];

    programs.niri.enable = true;
    services = {
      displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          appearance = {
            hide_logo = true;
            wallpaper = {
              path = "${../../../assets/greeter-wallpaper.png}";
              fill_mode = "crop";
            };
          };
          session.default = "niri";
        };
      };
      # COSMIC's Orca screen reader needs speechd; Niri has no consumer.
      speechd.enable = false;
    };
  };
}
