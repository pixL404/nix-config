{ pkgs, ... }:
let
  thunderbird-check = pkgs.writeShellApplication {
    name = "thunderbird-check";
    runtimeInputs = with pkgs; [ thunderbird-latest ];
    text = ''
      while true;
      do
        sleep 10m
        timeout 30 thunderbird --headless
      done
    '';
  };
in
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

  # check emails every 10min
  "${thunderbird-check}/bin/thunderbird-check"
]
