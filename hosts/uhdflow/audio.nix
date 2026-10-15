{ lib, pkgs, ... }:
let
  audioPresets = ./easyeffects;
  speaker = "alsa_output.pci-0000_c4_00.6.analog-stereo";
  microphone = "alsa_input.pci-0000_c4_00.6.analog-stereo";
  passthrough = {
    blocklist = [ ];
    plugins_order = [ ];
  };
  autoload = device: route: preset: {
    text = builtins.toJSON {
      inherit device;
      device-description = "Ryzen HD Audio Controller Analog Stereo";
      # EasyEffects matches the route description, not the ALSA port name.
      device-profile = route;
      preset-name = preset;
    };
  };

  # FlowMic expects 30% hardware gain; never adjust the default/external source.
  setMicrophoneVolume = pkgs.writeShellScript "uhdflow-microphone-volume" ''
    for attempt in {1..50}; do
      if ${pkgs.pulseaudio}/bin/pactl set-source-volume ${lib.escapeShellArg microphone} 30% 2>/dev/null; then
        exit 0
      fi
      ${pkgs.coreutils}/bin/sleep 0.1
    done
    echo "Built-in microphone unavailable; leaving other source volumes unchanged." >&2
  '';
in
{
  home-manager.users.uhdbits = {
    services.easyeffects = {
      enable = true;
      # Autoload chooses each pipeline independently. Do not force a startup
      # preset, which could apply speaker/mic processing to an external device.
      extraPresets.Bypass = {
        input = passthrough;
        output = passthrough;
      };
      settings = {
        Window = {
          inputAutoloadingUsesFallback = true;
          outputAutoloadingUsesFallback = true;
          inputAutoloadingFallbackPreset = "Bypass";
          outputAutoloadingFallbackPreset = "Bypass";
          # Avoid keeping the previous device's effects during an autoload delay.
          presetsAutoloadInterval = 0;
        };
        EffectsPipelines = {
          bypass = false;
          processAllInputs = true;
          processAllOutputs = true;
        };
        StreamInputs = {
          useDefaultInputDevice = true;
          listenToMic = false;
          # Start with an empty chain until device-specific autoload runs.
          plugins = null;
        };
        StreamOutputs = {
          useDefaultOutputDevice = true;
          plugins = null;
        };
      };
    };

    xdg.dataFile = {
      # Local copies from Naomarik/Z13-StrixHalo-Omarchy at
      # bd9735a594d0b55d2a4e1aa3739602bc0cd61ade.
      "easyeffects/input/FlowMic.json".source = "${audioPresets}/input/FlowMic.json";
      "easyeffects/output/IRZ13 Flow.json".source = "${audioPresets}/output/IRZ13 Flow.json";
      "easyeffects/irs/ir1.irs".source = "${audioPresets}/irs/ir1.irs";

      # Matching the port as well as the node excludes wired headphones on the
      # same sound card. USB, Bluetooth, HDMI and unknown ports use Bypass.
      "easyeffects/autoload/output/${speaker}:Speakers.json" = autoload speaker "Speakers" "IRZ13 Flow";
      "easyeffects/autoload/input/${microphone}:Internal Microphone.json" =
        autoload microphone "Internal Microphone" "FlowMic";
    };

    systemd.user.services = {
      easyeffects.Unit = {
        After = [ "uhdflow-microphone-volume.service" ];
        Wants = [ "uhdflow-microphone-volume.service" ];
      };
      uhdflow-microphone-volume = {
        Unit = {
          Description = "Set the built-in Flow Z13 microphone gain for FlowMic";
          After = [ "pipewire-pulse.service" ];
          Wants = [ "pipewire-pulse.service" ];
          Before = [ "easyeffects.service" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${setMicrophoneVolume}";
        };
      };
    };
  };
}
