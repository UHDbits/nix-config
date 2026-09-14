#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 HOST" >&2
  exit 2
fi

if [[ $EUID -ne 0 ]]; then
  echo "run this script as root" >&2
  exit 1
fi

checkout=$(pwd -P)
host=$1
password_file=/mnt/persist/secrets/userpassword

if [[ ! -f $checkout/flake.nix ]]; then
  echo "run this script from the configuration checkout" >&2
  exit 1
fi

if ! mountpoint -q /mnt/persist; then
  echo "/mnt/persist must be mounted before installation" >&2
  exit 1
fi

if [[ ! -e $password_file ]]; then
  install -d -m 0700 /mnt/persist/secrets
  umask 077
  temporary_password_file=$(mktemp /mnt/persist/secrets/userpassword.XXXXXX)
  trap 'rm -f "$temporary_password_file"' EXIT

  echo "Set the password for uhdbits."
  mkpasswd -m yescrypt > "$temporary_password_file"
  mv "$temporary_password_file" "$password_file"
fi

nixos-install --flake "$checkout#$host" --no-root-passwd
