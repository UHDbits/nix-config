{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  hm = config.home-manager.users.uhdbits;
  greeterCfg = config.services.displayManager.noctalia-greeter;

  wallpaperDir = "${inputs.wallpapers}/static";
  fallbackWallpaper = ../../../assets/greeter-wallpaper.png;
  # Picked once per boot, before the greeter starts; the Noctalia session
  # starts on the same image (see home/programs/niri.nix).
  bootWallpaper = "/run/boot-wallpaper";
  greeterToml = "/var/lib/noctalia-greeter/greeter.toml";

  # Match the greeter to the scale each host gives niri, instead of the
  # greeter guessing from panel DPI.
  sessionOutput = hm.wayland.windowManager.niri.settings.output or null;

  # One greeter.toml per wallpaper, each with the palette Noctalia derives from
  # that image using the session's scheme, so the greeter's colours match the
  # boot wallpaper. The boot-wallpaper service links the matching one in.
  baseGreeterToml = (pkgs.formats.toml { }).generate "greeter.toml" greeterCfg.settings;
  greeterVariants =
    pkgs.runCommand "noctalia-greeter-variants"
      {
        nativeBuildInputs = [
          hm.programs.noctalia.package
          pkgs.jq
        ];
      }
      ''
        export HOME=$TMPDIR XDG_CACHE_HOME=$TMPDIR/cache XDG_CONFIG_HOME=$TMPDIR/config XDG_STATE_HOME=$TMPDIR/state
        mkdir -p $out
        shopt -s nullglob nocaseglob
        for img in ${wallpaperDir}/*.{png,jpg,jpeg,webp}; do
          [ -f "$img" ] || continue
          name=$(basename "$img")
          noctalia theme "$img" --scheme ${hm.programs.noctalia.settings.theme.wallpaper_scheme} --dark -o palette.json
          {
            cat ${baseGreeterToml}
            printf '\n[appearance.palette]\n'
            jq -r 'to_entries[] | "\(.key) = \(.value | tojson)"' palette.json
          } > "$out/$name.toml"
        done
      '';
in
{
  config = lib.mkIf (config.desktop == "niri") {
    environment.systemPackages = with pkgs; [
      ddcutil
      nautilus
    ];

    # Lets Noctalia (via ddcutil) set external monitor brightness over DDC/CI.
    hardware.i2c.enable = true;
    users.users.uhdbits.extraGroups = [ "i2c" ];

    programs.niri.enable = true;
    services = {
      displayManager.noctalia-greeter = {
        enable = true;
        cursorTheme.package = pkgs.adwaita-icon-theme;
        settings = {
          appearance = {
            hide_logo = true;
            # Match the session's AM/PM clock (greeter defaults to 24-hour).
            time_format = "{:%I:%M %p}";
            wallpaper = {
              fill_mode = "crop";
              path = bootWallpaper;
            };
          };
          session.default = "niri";
          output = lib.mkIf (sessionOutput != null && sessionOutput ? _args && sessionOutput ? scale) {
            name = builtins.head sessionOutput._args;
            inherit (sessionOutput) scale;
          };
        };
      };
      # COSMIC's Orca screen reader needs speechd; Niri has no consumer.
      speechd.enable = false;
    };

    # greetd defaults to Type=idle, which stalls up to 5s waiting for other
    # boot jobs; that only matters for text greeters sharing the console.
    systemd.services.greetd.serviceConfig.Type = lib.mkForce "simple";

    # boot-wallpaper owns greeter.toml (it picks the per-wallpaper variant);
    # stop tmpfiles from resetting it to the palette-less config on switch.
    systemd.tmpfiles.settings."10-noctalia-greeter".${greeterToml} = lib.mkForce { };

    # Pre-create Helium's managed policy file as user-writable so Noctalia's
    # Helium template updates BrowserThemeColor without polkit prompts after
    # impermanent boots.
    systemd.tmpfiles.rules = lib.mkIf hm.programs.helium.enable [
      "d /etc/chromium/policies/managed 0755 root root -"
      "f /etc/chromium/policies/managed/noctalia-color.json 0644 uhdbits ${config.users.users.uhdbits.group} - {}"
    ];

    systemd.services.boot-wallpaper = {
      description = "Pick a random wallpaper for this boot";
      after = [ "systemd-tmpfiles-setup.service" ];
      before = [ "greetd.service" ];
      wantedBy = [ "greetd.service" ];
      path = [
        pkgs.coreutils
        pkgs.findutils
      ];
      # Only pick on boot, never on nixos-rebuild switch.
      restartIfChanged = false;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        pick=$(find ${wallpaperDir} -maxdepth 1 -type f \
          \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
          | shuf -n 1)
        ln -sfn "''${pick:-${fallbackWallpaper}}" ${bootWallpaper}

        variant=${baseGreeterToml}
        if [ -n "$pick" ] && [ -f "${greeterVariants}/$(basename "$pick").toml" ]; then
          variant="${greeterVariants}/$(basename "$pick").toml"
        fi
        ln -sfn "$variant" ${greeterToml}
      '';
    };
  };
}
