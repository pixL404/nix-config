# https://hyprpanel.com/getting_started/installation.html
{
  config,
  inputs,
  pkgs,
  lib ? pkgs.lib,
  ...
}:
let
  ifHost = host: value: (lib.mkIf (config.networking.hostName == "${host}") value);
in
{
  hm = {
    imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
    config = lib.mkIf config.graphical.hyprland.enable {

      programs.hyprpanel = {

        # Enable the module.
        # Default: false
        enable = true;

        # deprecated
        # systemd.enable = true;

        # Add '/nix/store/.../hyprpanel' to your
        # Hyprland config 'exec-once'.
        # Default: false
        hyprland.enable = true;

        # Fix the overwrite issue with HyprPanel.
        # See below for more information.
        # Default: false
        overwrite.enable = true;

        # Configure and theme almost all options from the GUI.
        # Options that require '{}' or '[]' are not yet implemented,
        # except for the layout above.
        # See 'https://hyprpanel.com/configuration/settings.html'.
        # Default: <same as gui>
        settings = {
          # Configure bar layouts for monitors.
          # See 'https://hyprpanel.com/configuration/panel.html'.
          # Default: null
          layout = {
            "bar.layouts" = {
              "0" = {
                left = [
                  "dashboard"
                  "workspaces"
                  "windowtitle"
                ];
                middle = [ "media" ];
                right = [
                  "systray"
                  "volume"
                  "network"
                  "bluetooth"
                  (ifHost "kosmo" "battery")
                  "notifications"
                  "clock"
                  "power"
                ];
              };
              "*" = {
                left = [ "workspaces" ];
                middle = [ "media" ];
                right = [
                  (ifHost "wanda" "systray")
                  "volume"
                  "clock"
                  (ifHost "wanda" "notifications")
                  (ifHost "wanda" "power")
                ];
              };
            };
          };

          bar = {
            launcher.autoDetectIcon = true;

            workspaces = {
              show_icons = false;
              show_numbered = true;
              workspaces = 4; # persistent
            };

            media.show_active_only = true;

            clock.format = "%H:%M";
          };

          menus = {
            clock = {
              time = {
                military = true;
                hideSeconds = true;
              };
              weather.enabled = false;
            };

            media.displayTimeTooltip = true;

            dashboard = {
              shortcuts.enabled = false;
              controls.enabled = true;
              directories.enabled = false;
              stats.enable_gpu = false;
            };

            power = {
              sleep = "systemctl hibernate";

              lowBatteryNotification = true;
              lowBatteryThreshold = 10;
            };
          };

          theme = {
            bar.transparent = true;
            font = {
              name = "CaskaydiaCove NF";
              size = "13px";
            };
          };
        };
      };
    };
  };
}
