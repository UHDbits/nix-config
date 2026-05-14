{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.frc-nix.overlays.default ];
}
