{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.frc-nix.overlays.default
    inputs.nix-cachyos-kernel.overlays.default ];
}
