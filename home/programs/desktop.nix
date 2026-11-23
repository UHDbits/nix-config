{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  # niri's default config minus the autostart and binds that call programs we
  # don't install; Noctalia replacements are bound in extraConfig below.
  niriDefaultConfig =
    pkgs.runCommand "niri-default-config.kdl"
      { src = "${config.wayland.windowManager.niri.package.src}/resources/default-config.kdl"; }
      ''
        grep -v -E \
          -e '^spawn-at-startup "waybar"' \
          -e '\{ *spawn(-sh)? "(alacritty|fuzzel|swaylock|brightnessctl)"' \
          -e 'spawn-sh "(pkill orca|playerctl)' \
          "$src" > $out
        # Fail the build if upstream changes and a line slips through.
        ! grep -q -E 'waybar|alacritty|fuzzel|swaylock|orca|playerctl|brightnessctl' <(grep -v '^\s*//' $out)
      '';
in
{
  imports = [
    inputs.codex-desktop-linux.homeManagerModules.default
    inputs.helium.homeModules.default
  ];

  home.packages = [
    inputs.claude-desktop-extra.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.cine
    pkgs.gitte
    pkgs.loupe
  ]
  ++ lib.optionals (osConfig.desktop == "niri") [
    pkgs.adwaita-icon-theme
  ];

  home.pointerCursor = lib.mkIf (osConfig.desktop == "niri") {
    enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  # adw-gtk3 uses libadwaita color names, so GTK3 apps (e.g. the pinentry/gcr
  # prompter) go dark and pick up Noctalia's generated gtk-3.0/noctalia.css.
  gtk = lib.mkIf (osConfig.desktop == "niri") {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs = {
    codexDesktopLinux.enable = true;
    helium = {
      enable = true;
      flags = [ "--ozone-platform-hint=auto" ];
    };
    noctalia = lib.mkIf (osConfig.desktop == "niri") {
      enable = true;
      systemd.enable = true;
      settings = {
        # Shown behind workspaces in the overview (see the niri layer-rule).
        backdrop.enabled = true;
        bar.default = {
          start = [
            "control-center"
            "workspaces"
          ];
          center = [ ];
          end = [
            "battery"
            "network"
            "launcher"
            "bar" # USB manager plugin, see widget.bar
            "date"
          ];
          background_opacity = 0.7;
          concave_edge_corners = false;
          font_weight = 600;
          margin_ends = 0;
          radius = 0;
          radius_bottom_left = 0;
          radius_bottom_right = 0;
          radius_top_left = 0;
          radius_top_right = 0;
          scale = 0.95;
          thickness = 32;
        };
        battery.warning_threshold = 15;
        bluetooth.connect_when_enabled = true;
        # External monitor brightness (ddcutil + i2c set up in niri.nix).
        brightness.enable_ddcutil = true;
        calendar.event_time_format = "%I:%M %p";
        control_center.calendar.show_events_card = false;
        control_center.shortcuts = map (type: { inherit type; }) [
          "wifi"
          "bluetooth"
          "caffeine"
          "nightlight"
          "nikolaj-zwergius/iio_lock:toggle"
          "bagusk99/super-caffeine:super-caffeine-toggle"
        ];
        desktop_widgets.enabled = false;
        dock = {
          enabled = true;
          auto_hide = true;
          background_opacity = 0.26;
          border_width = 1.0;
          concave_edge_corners = false;
          launcher_position = "start";
          layer = "overlay";
          magnification = false;
          margin_edge = 8;
          radius = 24;
          reserve_space = false;
          show_dots = true;
        };
        idle = {
          pre_action_fade_seconds = 5.0;
          # Setting any behaviour replaces Noctalia's defaults, so list all.
          behavior_order = [
            "lock"
            "screen-off"
            "lock-and-suspend"
          ];
          behavior =
            lib.mapAttrs
              (
                _: b:
                {
                  enabled = false;
                  command = "";
                  resume_command = "";
                  locked_timeout = 0.0;
                }
                // b
              )
              {
                lock = {
                  action = "lock";
                  timeout = 300.0;
                };
                screen-off = {
                  action = "screen_off";
                  timeout = 660.0;
                };
                lock-and-suspend = {
                  action = "lock_and_suspend";
                  timeout = 900.0;
                };
              };
        };
        location = {
          address = "Scottsdale, AZ";
          custom_schedule = true;
          sunrise = "06:00";
          sunset = "21:00";
        };
        lockscreen = {
          blur_intensity = 0.7;
          blurred_desktop = true;
          fingerprint = false;
          transition = [ "fade" ];
          transition_duration = 500;
        };
        lockscreen_widgets = {
          enabled = true;
          widget_order = [
            "lockscreen-login-box@eDP-1"
            "lockscreen-widget-0000000000000001"
          ];
          widget = {
            "lockscreen-login-box@eDP-1" = {
              type = "login_box";
              output = "eDP-1";
              box_height = 196.0;
              box_width = 810.0;
              cx = 960.0;
              cy = 910.0;
              placement_height = 1080.0;
              placement_width = 1920.0;
              rotation = 0.0;
              settings = {
                background_color = "surface_container";
                background_opacity = 0.88;
                background_radius = 12.0;
                center_password_text = false;
                input_opacity = 1.0;
                input_radius = 6.0;
                layout = "regular";
                show_caps_lock = true;
                show_keyboard_layout = true;
                show_login_button = true;
                show_media = true;
                show_media_controls = true;
                show_password_reveal = true;
                show_session_buttons = true;
                show_unlock_hint = true;
                show_weather = true;
              };
            };
            lockscreen-widget-0000000000000001 = {
              type = "clock";
              output = "eDP-1";
              box_height = 144.0;
              box_width = 528.0;
              cx = 960.0;
              cy = 236.0;
              placement_height = 1080.0;
              placement_width = 1920.0;
              rotation = 0.0;
              settings = {
                background_radius = 20;
                font_family = "";
                format = "{:%I:%M %p}";
              };
            };
          };
        };
        nightlight.enabled = true;
        osd.background_opacity = 0.5;
        # Only the plugins the settings above use.
        plugins.enabled = [
          "bagusk99/super-caffeine"
          "nikolaj-zwergius/iio_lock"
          "rylos/usb-manager"
        ];
        plugin_settings."rylos/usb-manager".panel_placement = "floating";
        shell = {
          corner_radius_scale = 1.8;
          font_family = "Adwaita Sans";
          lang = "en";
          polkit_agent = true;
          show_location = false;
          # Fallback for UI without its own format; the bar clock and lock
          # screen clock widgets set theirs separately.
          time_format = "{:%I:%M %p}";
          # Start apps in their own units so a Noctalia restart (e.g. on
          # rebuild) can't kill their helper processes.
          launch_apps_as_systemd_services = true;
          animation.speed = 1.5;
          launcher = {
            category_icons_only = true;
            default_view = "all";
            fetch_exchange_rates = false;
            layout = "simple";
            show_app_origin_indicator = false;
            width = 640;
          };
          panel = {
            control_center_placement = "floating";
            open_near_click_control_center = true;
            session_placement = "floating";
            transparency_mode = "soft";
          };
          screenshot = {
            annotate = true;
            confirm_region = true;
            directory = "${config.home.homeDirectory}/Pictures/Screenshots";
            skip_annotate_on_copy_save = true;
          };
        };
        theme = {
          mode = "dark";
          source = "wallpaper";
          wallpaper_scheme = "m3-content";
          templates = {
            builtin_ids = [
              "btop"
              "gtk3"
              "gtk4"
              "ghostty"
              "kcolorscheme"
              "niri"
              "qt"
            ];
            community_ids = [
              "claude-code"
              "codex"
              "micro"
              "zed"
              "fastfetch"
              "cosmic"
              "fcitx5"
            ];
          };
        };
        wallpaper = {
          directory = "${inputs.wallpapers}/static";
          transition = [
            "fade"
            "pixel"
            "wipe"
            "zoom"
          ];
        };
        weather.unit = "imperial";
        widget = {
          clock = {
            type = "clock";
            capsule = false;
            format = "{:%I:%M %p}";
          };
          date = {
            type = "clock";
            format = "{:%a %d %b %I:%M %p}";
          };
          network = {
            type = "network";
            show_label = false;
          };
          bar.type = "rylos/usb-manager:bar";
        };
      };
    };
    t3code = {
      enable = true;
      package = pkgs.t3code.override { enableClaude = true; };
    };
    thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = { };
      };
    };
  };

  # Seed Noctalia's persisted wallpaper with the one picked at boot
  # (modules/features/desktops/niri.nix) before it starts, so the session
  # matches the greeter and opens on it without fading from the old one.
  systemd.user.services.noctalia.Service.ExecStartPre = lib.mkIf (osConfig.desktop == "niri") (
    toString (
      pkgs.writeShellScript "noctalia-seed-boot-wallpaper" ''
        target=$(${pkgs.coreutils}/bin/readlink -e /run/boot-wallpaper) || exit 0
        state="${config.xdg.stateHome}/noctalia/settings.toml"
        ${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$state")"
        tmp=$(${pkgs.coreutils}/bin/mktemp "$state.XXXXXX")
        {
          if [ -f "$state" ]; then
            # Drop the saved default/last/per-monitor wallpaper tables.
            ${pkgs.gawk}/bin/awk '
              /^[[:space:]]*\[/ { skip = ($0 ~ /^[[:space:]]*\[wallpaper\.(default|last|monitors\.[^]]*)\][[:space:]]*$/) }
              !skip { line[n++] = $0 }
              END { while (n > 0 && line[n - 1] ~ /^[[:space:]]*$/) n--; for (i = 0; i < n; i++) print line[i] }
            ' "$state"
          fi
          printf '\n[wallpaper.default]\npath = "%s"\n\n[wallpaper.last]\npath = "%s"\n' "$target" "$target"
        } > "$tmp"
        ${pkgs.coreutils}/bin/mv "$tmp" "$state"
      ''
    )
  );

  wayland.windowManager.niri = lib.mkIf (osConfig.desktop == "niri") {
    enable = true;
    # Included below without the binds/autostart for programs we don't install
    # (waybar, alacritty, fuzzel, swaylock, orca, playerctl, brightnessctl).
    enableDefaultConfig = false;
    settings.cursor = {
      xcursor-size = config.home.pointerCursor.size;
      xcursor-theme = config.home.pointerCursor.name;
    };
    extraConfig = lib.mkMerge [
      (lib.mkOrder 501 ''include "${niriDefaultConfig}"'')
      ''
        window-rule {
          // Rounded corners for a modern look.
          geometry-corner-radius 20

          // Clips window contents to the rounded corner boundaries.
          clip-to-geometry true
        }

        // Floating Noctalia settings window.
        window-rule {
          match app-id="dev.noctalia.Noctalia"
          open-floating true
          default-column-width { fixed 1080; }
          default-window-height { fixed 920; }
        }

        debug {
          // Allows notification actions and window activation from Noctalia.
          honor-xdg-activation-with-invalid-serial
        }

        binds {
          XF86MonBrightnessUp allow-when-locked=true { spawn-sh "noctalia msg brightness-up"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn-sh "noctalia msg brightness-down"; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "noctalia msg volume-up"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn-sh "noctalia msg volume-down"; }
          XF86AudioMute allow-when-locked=true { spawn-sh "noctalia msg volume-mute"; }
          XF86AudioMicMute allow-when-locked=true { spawn-sh "noctalia msg mic-mute"; }

          XF86AudioPlay allow-when-locked=true { spawn-sh "noctalia msg media toggle"; }
          XF86AudioStop allow-when-locked=true { spawn-sh "noctalia msg media stop"; }
          XF86AudioPrev allow-when-locked=true { spawn-sh "noctalia msg media previous"; }
          XF86AudioNext allow-when-locked=true { spawn-sh "noctalia msg media next"; }

          Mod+Space hotkey-overlay-title="Run an Application" { spawn-sh "noctalia msg panel-toggle launcher"; }
          Mod+T hotkey-overlay-title="Open a Terminal: Ghostty" { spawn "ghostty"; }
          Mod+V hotkey-overlay-title="Clipboard History" { spawn-sh "noctalia msg panel-toggle clipboard"; }
          Mod+L hotkey-overlay-title="Lock the Screen" { spawn-sh "noctalia msg session lock"; }

          Print { spawn-sh "noctalia msg screenshot-region --annotate"; }
          Ctrl+Print { spawn-sh "noctalia msg screenshot-fullscreen"; }
          Alt+Print { spawn-sh "noctalia msg screenshot-window"; }
        Mod+S hotkey-overlay-title="Screenshot Region" { spawn-sh "noctalia msg screenshot-region --annotate"; }
        Mod+Shift+S hotkey-overlay-title="Screenshot Window" { spawn-sh "noctalia msg screenshot-window"; }
        }

        // Show Noctalia's backdrop in the overview and between workspaces.
        layer-rule {
          match namespace="^noctalia-backdrop"
          place-within-backdrop true
        }

        // Blur (on by default when a surface requests it) shows what is really
        // behind each window or panel, not only the wallpaper (xray).
        window-rule {
          background-effect {
            xray false
          }
        }
        layer-rule {
          background-effect {
            xray false
          }
        }

        include optional=true "${config.xdg.configHome}/niri/noctalia.kdl"
      ''
    ];
  };
}
