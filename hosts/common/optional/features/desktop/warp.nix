# Nix configuration file to enable Cloudflare WARP.
{ lib, ... }:
{
  services.cloudflare-warp.enable = lib.mkDefault true;
}
