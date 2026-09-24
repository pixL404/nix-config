{
  config,
  lib,
  ...
}:
let
  service = "arrUsers";
  cfg = config.homelab.services.${service};
in
{
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    group = lib.mkOption {
      type = lib.types.str;
      default = "arr";
    };
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "jellyfin"
        "qbittorrent"
        "radarr"
        "sonarr"
      ];
    };
  };
  config = lib.mkIf cfg.enable {
    users.users = builtins.listToAttrs (
      map (userName: {
        name = userName;
        value = {
          enable = true;
          isSystemUser = true;
        };
      }) cfg.users
    );
    users.groups.${cfg.group}.members = cfg.users;
  };
}
