{ pkgs, ... }:
let
  audioFiles = pkgs.fetchFromGitHub {
    hash = "sha256-x7K0qa++P1e1vuCGxnsFxL1d9+nwMtZUJ6Kd9e27TFs=";
    owner = "kekrby";
    repo = "t2-better-audio";
    rev = "e46839a28963e2f7d364020518b9dac98236bcae";
  };
  audioUdevRules = pkgs.runCommand "t2-audio-udev-rules" { } ''
    mkdir -p $out/lib/udev/rules.d
    cp ${audioFiles}/files/*.rules $out/lib/udev/rules.d
    substituteInPlace $out/lib/udev/rules.d/*.rules --replace /usr/bin/sed ${pkgs.gnused}/bin/sed
  '';
  t2Pipewire = pkgs.pipewire.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      cp -r ${audioFiles}/files/{profile-sets,paths} spa/plugins/alsa/mixer/
    '';
  });
in
{
  services = {
    pipewire.package = t2Pipewire;
    pipewire.wireplumber.package = pkgs.wireplumber.override { pipewire = t2Pipewire; };
    udev.packages = [ audioUdevRules ];
  };
}
