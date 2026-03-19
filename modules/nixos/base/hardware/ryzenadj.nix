# NixOS module to enable RyzenAdj.
{ pkgs, ... }:
{
  environment.systemPacakges = [ pkgs.ryzenAdj ];
  hardware.cpu.amd.ryzen-smu.enable = true;
}
