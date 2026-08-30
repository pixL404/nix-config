{
  config,
  lib,
  ...
}:
let
  service = "pihole";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in
{
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${homelab.baseDomain}";
    };
  };
  config = lib.mkIf cfg.enable {
    services.pihole-ftl = {
      enable = true;
      openFirewallDNS = true;

      lists = [
        {
          # https://github.com/hagezi/dns-blocklists#pro
          enabled = true;
          description = "hagezii Multi Pro";
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt";
          type = "block";
        }
      ];

      settings.dns.upstreams = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];

      settings.misc.dnsmasq_lines = [ "address=/${homelab.baseDomain}/192.168.178.80" ];

      queryLogDeleter.enable = true;
    };
    services.pihole-web = {
      enable = true;
      ports = [ 9090 ];
    };

    services.caddy.virtualHosts."${cfg.url}" = {
      useACMEHost = homelab.baseDomain;
      extraConfig = ''
        @denied not client_ip private_ranges
        abort @denied

        reverse_proxy http://127.0.0.1:9090
      '';
    };

  };
}
