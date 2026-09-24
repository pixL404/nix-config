{
  config,
  lib,
  pkgs,
  ...
}:
let
  service = "torrent";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in
{
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/data/arr/${service}";
    };
    webuiPort = lib.mkOption {
      type = lib.types.int;
      default = 7777; # <- gambling :)
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${homelab.baseDomain}";
    };
  };
  config = lib.mkIf cfg.enable {
    services.qbittorrent = {
      enable = true;
      webuiPort = cfg.webuiPort;
      extraArgs = [
        "--confirm-legal-notice"
      ];

      group = homelab.services.arrUsers.group;

      profileDir = cfg.dataDir;

      serverConfig = {
        BitTorrent.Session.Interface = "proton0";
        BitTorrent.Session.InterfaceName = "proton0";
        Preferences.WebUI = {
          Username = "alex";
          #  nix run git+https://codeberg.org/feathecutie/qbittorrent_password -- -p <password>
          Password_PBKDF2 = "@ByteArray(qVPeTQmdN4K/LhMahDNuXg==:/jZKfRC3fU6qfeKnZ9DM4hLcqBbhFCTnjYFYOretoHEuGTP11eZWySndZmo11vkqlEdVIeID+Pj1UAv8hxwLdQ==)";
        };
      };

    };

    services.caddy.virtualHosts."${cfg.url}" = {
      useACMEHost = homelab.baseDomain;
      extraConfig = ''
        @denied not client_ip private_ranges
        abort @denied

        reverse_proxy http://127.0.0.1:${toString cfg.webuiPort}
      '';
    };
    networking.wg-quick.interfaces.proton0 = {
      privateKeyFile = "/etc/private/wireguard_key";

      table = "off";
      address = [ "10.2.0.2/32" ];
      postUp = ''
        ip route add default dev proton0 table 51820
        ip rule add from 10.2.0.2/32 table 51820
      '';

      postDown = ''
        ip rule delete from 10.2.0.2/32 table 51820
        ip route delete default dev proton0 table 51820
      '';
      # dns = [ "10.2.0.1" ];
      # Bouncing = 9
      # NetShield = 0
      # Moderate NAT = off
      # NAT-PMP (Port Forwarding) = on
      # VPN Accelerator = off

      peers = [
        {
          # AT#122
          publicKey = "D2G0wjy9kRvxjXJfLCA9zglgcwMvZFMhLG+NASSzQ1k=";
          endpoint = "154.47.19.212:51820";
          allowedIPs = [ "0.0.0.0/0" ]; # do not set IPv6 to prevent leaks
          persistentKeepalive = 25;
        }
      ];
    };
    systemd.services.qbittorrent = {
      after = [
        "wg-quick-proton0.service"
        "sys-subsystem-net-devices-proton0.device"
      ];
      requires = [ "wg-quick-proton0.service" ];
      bindsTo = [ "sys-subsystem-net-devices-proton0.device" ];
    };
    systemd.services.protonvpn-port-forward = {
      description = "ProtonVPN NAT-PMP Port Forwarding for qBittorrent";
      after = [
        "sys-subsystem-net-devices-proton0.device"
        "qbittorrent.service"
      ];
      bindsTo = [ "sys-subsystem-net-devices-proton0.device" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        QBIT_URL="http://127.0.0.1:${toString cfg.webuiPort}"
        GATEWAY="10.2.0.1"

        while true; do
          # Request TCP and UDP port mapping for 60 seconds
          ${pkgs.libnatpmp}/bin/natpmpc -a 1 0 tcp 60 -g $GATEWAY > /tmp/natpmp.log
          ${pkgs.libnatpmp}/bin/natpmpc -a 1 0 udp 60 -g $GATEWAY >> /tmp/natpmp.log
          
          # Extract the assigned port
          PORT=$(grep -oP 'Mapped public port \K\d+' /tmp/natpmp.log | head -n1)
          
          if [ -n "$PORT" ]; then
            # Check current port in qBittorrent
            CURRENT_PORT=$(${pkgs.curl}/bin/curl -s "$QBIT_URL/api/v2/app/preferences" | ${pkgs.jq}/bin/jq '.listen_port')
            
            if [ "$PORT" != "$CURRENT_PORT" ]; then
              echo "Updating qBittorrent port from $CURRENT_PORT to $PORT"
              ${pkgs.curl}/bin/curl -s -X POST -d "json={\"listen_port\":$PORT}" "$QBIT_URL/api/v2/app/setPreferences"
            fi
          fi
          
          # Sleep for 45 seconds (must be less than 60s to maintain the lease)
          sleep 45
        done
      '';

      serviceConfig = {
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
