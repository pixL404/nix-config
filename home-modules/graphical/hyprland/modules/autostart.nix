{ pkgs, ... }:
[
  "waypaper --restore --backend swaybg --fill fill"
  # "waybar"
  "foot --server"
  "systemctl --user start hyprpolkitagent"
  # "solaar-cli -w hide"
  # "blueman-applet"
  "easyeffects --gappliation-service"

  "vivaldi"
  "steam"
  "vesktop"

  "${pkgs.hyprpanel}/bin/hyprpanel"

  # clipboard
  "wl-paste --type text --watch cliphist store"
  "wl-paste --type image --watch cliphist store"
]
