{
  config,
  lib,
  ...
}:
let
  service = "jellyfin";
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
      default = "/data/${service}";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${homelab.baseDomain}";
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;

      hardwareAcceleration = {
        enable = true;
        type = "vaapi"; # amf alternatiely
        device = "/dev/dri/renderD128";
      };
      transcoding.enableHardwareEncoding = true;

      dataDir = cfg.dataDir;
      logDir = "/var/log/jellyfin";

      openFirewall = true;
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      useACMEHost = homelab.baseDomain;
      extraConfig = ''
        @denied not client_ip private_ranges
        abort @denied

        reverse_proxy http://127.0.0.1:8096
      '';
    };
  };
}
