{ pkgs, ... }:
let
  warpName = "Cloudflare WARP";
  warpState = "/var/lib/NetworkManager/wgcf";
in
{
  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeShellScript "cloudflare-warp-dispatcher" ''
        if [ "$2" = up ] || { [ "$2" = connectivity-change ] && [ "''${CONNECTIVITY_STATE:-}" = FULL ]; }; then
          ${pkgs.systemd}/bin/systemctl --no-block start cloudflare-warp-setup.service
        fi
        if [ "$1" != cloudflare-warp ] && { [ "$2" = up ] || [ "$2" = down ]; }; then
          ${pkgs.systemd}/bin/systemctl --no-block start cloudflare-warp-disable.service
        fi
      '';
    }
  ];

  powerManagement.powerDownCommands = ''
    ${pkgs.networkmanager}/bin/nmcli connection down id '${warpName}' >/dev/null 2>&1 || true
  '';

  systemd = {
    services = {
      cloudflare-warp-disable = {
        after = [ "NetworkManager.service" ];
        description = "Disable Cloudflare WARP";
        script = ''
          ${pkgs.networkmanager}/bin/nmcli connection down id '${warpName}' >/dev/null 2>&1 || true
        '';
        serviceConfig.Type = "oneshot";
        wantedBy = [ "multi-user.target" ];
      };

      cloudflare-warp-setup = {
        after = [
          "NetworkManager.service"
          "network-online.target"
        ];
        description = "Generate the Cloudflare WARP NetworkManager profile";
        path = [
          pkgs.coreutils
          pkgs.gnused
          pkgs.networkmanager
          pkgs.wgcf
        ];
        script = ''
          if nmcli connection show '${warpName}' >/dev/null 2>&1; then
            nmcli connection modify '${warpName}' connection.autoconnect no
            exit 0
          fi

          cd '${warpState}'
          if [ ! -s wgcf-account.toml ]; then
            wgcf register --accept-tos
          fi
          if [ ! -s wgcf-profile.conf ]; then
            wgcf generate
          fi

          profile_value() {
            sed -n "s/^$1 = //p" wgcf-profile.conf
          }

          private_key="$(profile_value PrivateKey)"
          addresses="$(profile_value Address)"
          public_key="$(profile_value PublicKey)"
          endpoint="$(profile_value Endpoint)"
          ipv4_address="''${addresses%%,*}"
          ipv6_address="''${addresses#*, }"

          test -n "$private_key"
          test -n "$ipv4_address"
          test -n "$ipv6_address"
          test -n "$public_key"
          test -n "$endpoint"

          nmcli --offline connection add \
            type wireguard \
            con-name '${warpName}' \
            ifname cloudflare-warp \
            autoconnect no \
            -- \
            wireguard.private-key "$private_key" \
            wireguard.mtu 1280 \
            wireguard.peer-routes yes \
            wireguard.peers "$public_key endpoint=$endpoint allowed-ips=0.0.0.0/0;::/0" \
            ipv4.method manual \
            ipv4.addresses "$ipv4_address" \
            ipv4.dns "1.1.1.1,1.0.0.1" \
            ipv6.method manual \
            ipv6.addresses "$ipv6_address" \
            ipv6.dns "2606:4700:4700::1111,2606:4700:4700::1001" \
            > cloudflare-warp.nmconnection

          install -m 0600 cloudflare-warp.nmconnection \
            /etc/NetworkManager/system-connections/cloudflare-warp.nmconnection
          nmcli connection reload
          nmcli connection show '${warpName}' >/dev/null
        '';
        serviceConfig = {
          Type = "oneshot";
          UMask = "0077";
        };
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
      };
    };
    tmpfiles.rules = [ "d ${warpState} 0700 root root -" ];
  };
}
