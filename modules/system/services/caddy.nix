{
  config,
  lib,
  ...
}:
let
  homelab = config.homelab;
in
{
  config = lib.mkIf config.custom.isServer {
    security.acme = {
      acceptTerms = true;
      defaults.email = "alexostresso@gmail.com";
      certs.${homelab.baseDomain} = {
        reloadServices = [ "caddy.service" ];
        domain = homelab.baseDomain;
        extraDomainNames = [ "*.${homelab.baseDomain}" ];
        dnsProvider = "duckdns";
        dnsResolver = "1.1.1.1:53";
        group = config.services.caddy.group;
        environmentFile = "/var/lib/duckdns.env";
      };
    };
    services.caddy = {
      enable = true;
      openFirewall = true;

      globalConfig = ''
        auto_https off
      '';

      virtualHosts = {
        "http://${homelab.baseDomain}".extraConfig = ''
          redir https://{host}{uri}
        '';
        "http://*.${homelab.baseDomain}".extraConfig = ''
          redir https://{host}{uri}
        '';
        "https://${homelab.baseDomain}" = {
          # serverAliases = [ homelab.baseDomain ];
          # listenAddresses = [
          #   "127.0.0.1"
          #   "::1"
          # ];
          # keep this as compatibility for older systems using domain.org/vault instead of vault.domain.org
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

            redir /vault /vault/ permanent
            handle_path /vault/* {
              reverse_proxy * http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT} {
                header_up X-Real-IP {remote_host}
              }
            }
          '';
        };
      };
    };
  };
}
