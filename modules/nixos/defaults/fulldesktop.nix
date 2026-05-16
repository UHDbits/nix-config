{
  lib,
  ...
}: {
  imports = [
    ../../base/locale.nix
    ../../base/nix.nix
    ../../base/users.nix
    ../base/misc.nix
    ../base/overlays.nix
    ../desktop/dewm/cosmic.nix
    ../hardware/sound.nix
    ../hardware/ssd.nix
  ];
}
