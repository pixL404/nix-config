{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.custom.gaming;
in
{
  options = {
    custom.gaming.gameStreamHost = lib.mkEnableOption "If this host is designated for streaming games to other devices";
  };
  config = lib.mkIf cfg.gameStreamHost {
    services.sunshine = {
      enable = true;

      capSysAdmin = true;
      openFirewall = true;

      applications.apps = [
        {
          name = "STEAM STREAMING";
          prep-cmd = [
            {
              do = "hyprctl keyword monitor 'DP-1, 3840x2160@60, auto, 1.000000, bitdepth, 10, vrr, 0'";
              undo = "hyprctl keyword monitor 'DP-1, 2560x1440@180, 0x0, 1.000000, bitdepth, 8, vrr, 2'";
            }
          ];
          cmd = "gamescope -e -- /usr/bin/steam -tenfoot";
        }
      ];
    };
  };
}
