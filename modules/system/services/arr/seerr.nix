{
  config,
  lib,
  ...
}:
let
  service = "seerr";
  cfg = config.homelab.services.${service};
  homelab = config.homelab;
in
{
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 5055;
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${homelab.baseDomain}";
    };
  };
  config = lib.mkIf cfg.enable {
    services.seerr = {
      enable = true;
      port = cfg.port;
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      useACMEHost = homelab.baseDomain;
      extraConfig = ''
        @denied not client_ip private_ranges
        abort @denied

        reverse_proxy http://127.0.0.1:${toString cfg.port}
      '';
    };
  };
}
