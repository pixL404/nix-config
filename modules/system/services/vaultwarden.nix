{
  config,
  lib,
  ...
}:
let
  service = "vault";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in
{
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    backupDir = lib.mkOption {
      type = lib.types.str;
      default = "/data/backup/${service}";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${homelab.baseDomain}";
    };
  };
  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      domain = homelab.baseDomain;
      backupDir = cfg.backupDir;
      config = {
        WEBSOCKET_ENABLED = false;
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      useACMEHost = homelab.baseDomain;
      extraConfig = ''
        encode gzip

        header {
          # Enable HTTP Strict Transport Security (HSTS)
          Strict-Transport-Security "max-age=31536000;"
          # Enable cross-site filter (XSS) and tell browser to block detected attacks
          X-XSS-Protection "1; mode=block"
          # Disallow the site to be rendered within a frame (clickjacking protection)
          X-Frame-Options "DENY"
          # Prevent search engines from indexing (optional)
          X-Robots-Tag "none"
          # Server name removing
          -Server
        }

        reverse_proxy * http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT} {
          header_up X-Real-IP {remote_host}
        }
      '';
    };
  };
}
