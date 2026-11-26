# nix-config

Personal NixOS flake configuration (`nixos-unstable`) using Home Manager, Btrfs impermanence, Limine, and CachyOS kernels.

## Hosts

- **`uhdflow`** — ASUS ROG Flow Z13 (Niri + Noctalia, EasyEffects speaker/mic presets, tablet auto-rotation + on-screen keyboard, `z13helper`)
- **`uhdprobook`** — HP ProBook 445 G9 (Niri + Noctalia)

## Layout

- `flake.nix` — Flake inputs, substituters, formatter (`nixfmt-tree`), and host list
- `lib/` — `scanPaths` auto-import helper
- `modules/base/` — Core system modules (Limine + Plymouth boot, Btrfs + LUKS2 + impermanence storage, zswap/swapfile, users)
- `modules/features/` — Shared system features (audio, connectivity, desktops, Nix settings, system programs, Cloudflare WARP)
- `hosts/<host>/` — Per-host configuration and hardware tweaks (auto-imports sibling `.nix` files)
- `home/` — Home Manager configuration for `uhdbits` (`desktop.nix`, `niri.nix`, `shell.nix`, `flatpak.nix`)
- `scripts/install-host.sh` — Fresh-install helper that initializes `/mnt/persist/secrets/userpassword` and runs `nixos-install`

## Common Commands

```sh
# Rebuild current host
nh os switch

# Format all Nix files
nix fmt

# Validate flake evaluation
nix flake check --no-build

# Fresh install from a live ISO (with /mnt and /mnt/persist mounted)
sudo ./scripts/install-host.sh <host>
```

## Adding a Host

1. Create `hosts/<name>/default.nix` (and optional sibling `.nix` files like `hardware.nix`).
2. Add `"<name>"` to `hosts` in `flake.nix`.
