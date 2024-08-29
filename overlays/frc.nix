{ inputs, ... }:
{
  frc-packages = final: _prev: {
    frc = import inputs.frc-nix {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
