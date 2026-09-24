{
  config,
  lib,
  ...
}:
let
  service = "recyclarr";
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

      configuration = {
        radarr.radarr-main = {
          base_url = "https://radarr.${homelab.baseDomain}:${toString config.services.radarr.settings.server.port}";
          api_key = {
            _secret = "/etc/private/radarr_apikey";
          };

          include = [
            { template = "radarr-quality-definition-movie"; }
            { template = "radarr-quality-profile-anime"; }
            { template = "radarr-quality-profile-german"; }
          ];

          quality_profiles = [
            # Requirement: 4K Original Language with 1080p Fallback
            {
              name = "4K with 1080p Fallback";
              upgrade = {
                allowed = true;
                until_quality = "Remux-2160p";
                until_score = 10000;
              };
              # The order here is critical. Top is most preferred.
              qualities = [
                { name = "Remux-2160p"; }
                { name = "WEB 2160p"; }
                { name = "Remux-1080p"; }
                { name = "WEB 1080p"; }
                { name = "Bluray-1080p"; }
              ];
            }
          ];

          custom_formats = [
            # Requirement: Prioritize embedded English & German Subtitles
            {
              trash_ids = [
                "026d5aadd1a6b4e550b134cb6c72b3ca" # Multi-Subs
                "4c23fbcc8714eb58c5a24d262ca1387d" # DE Subs
              ];
              assign_scores_to = [
                { name = "4K with 1080p Fallback"; }
                { name = "Remux-1080p - Anime"; } # Applies to included Anime profile
              ];
            }
          ];
        };
        sonarr.sonarr-main = {
          base_url = "https://radarr.${homelab.baseDomain}:${toString config.services.radarr.settings.server.port}";
          api_key = {
            _secret = "/etc/private/radarr_apikey";
          };
          include = [
            { template = "sonarr-quality-definition-series"; }
            { template = "sonarr-quality-definition-anime"; }
            { template = "sonarr-quality-profile-anime"; }
            { template = "sonarr-quality-profile-german"; }
          ];

          quality_profiles = [
            # Requirement: 4K Original Language with 1080p Fallback for Series
            {
              name = "4K with 1080p Fallback";
              upgrade = {
                allowed = true;
                until_quality = "Remux-2160p";
                until_score = 10000;
              };
              qualities = [
                { name = "Remux-2160p"; }
                { name = "WEB 2160p"; }
                { name = "Remux-1080p"; }
                { name = "WEB 1080p"; }
                { name = "Bluray-1080p"; }
              ];
            }
          ];

          custom_formats = [
            {
              trash_ids = [
                "026d5aadd1a6b4e550b134cb6c72b3ca" # Multi-Subs
                "4c23fbcc8714eb58c5a24d262ca1387d" # DE Subs
              ];
              assign_scores_to = [
                { name = "4K with 1080p Fallback"; }
                { name = "Remux-1080p - Anime"; }
              ];
            }
          ];
        };
      };
    };
  };
}
