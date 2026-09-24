{
  config,
  lib,
  ...
}:
let
  service = "sonarr";
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
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${homelab.baseDomain}";
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;

      group = homelab.services.arrUsers.group;

      # dataDir = cfg.dataDir;

      settings.log.analyticsEnabled = false;
    };
    # make available under subdomain
    services.caddy.virtualHosts."${cfg.url}" = {
      useACMEHost = homelab.baseDomain;
      extraConfig = ''
        @denied not client_ip private_ranges
        abort @denied

        reverse_proxy http://127.0.0.1:${toString config.services.${service}.settings.server.port}
      '';
    };
  };
}
