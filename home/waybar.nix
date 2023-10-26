{ config, pkgs, ... }:
let
  catppuccinColors = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/waybar/57d8d020a0c9aa3dd8038f9acb31ed8c7e2a78c6/themes/frappe.css";
    # hash of the nix derivation, not the git commit hash
    hash = "sha256-PkrBXymbwYWsdWV0nP+RRZtLAKwXOJOstLKDgrPnOtg=";
  });
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
      patches = (oa.patches or []) ++ [
        (pkgs.fetchpatch {
          name = "fix waybar hyprctl";
          url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
          sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
        })
      ];
    });
    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        exclusive = true;
        fixed-center = true;
        spacing = 8;
        margin = "4";

        modules-left = [ "hyprland/workspaces" ];

        modules-center = [ "hyprland/window" ];

        modules-right = [
          "tray"
          
          "network"
          "wireplumber"
          "backlight"
          "battery"
          "clock"
          "group/power"
        ];

        "hyprland/workspaces" = {
          format = "<sub>{name}</sub>"; #"<sub>{name}</sub> {windows}";
          format-window-separator = " ";
          window-rewrite-default = "?";
          window-rewrite = {
            "vivaldi" = "";
            "foot" = "";
            "code" = "";
            "steam" = "";
          };
          persistent-workspaces = {
            eDP-1 = 5;
          };
        };

        "hyprland/window" = {
          max-length = 50;
          rewrite = {
            "(.*) - Vivaldi" = " $1";
            "(.*) - fish" = "  $1";
          };
        };

        "clock" = {
          format = "{:%H:%M}";
          #timezone = "Europe/Vienna";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            #weeks-pos = "left";
            on-scroll = 1;
#            format = {
#              weeks = "{:%U}";
#              weekdays = "   Mo,Tu,We,Th,Fr,Sa,Su";
#            };
          };
          actions = {
            on-click = "mode";
            on-scroll-up = "shift_down";
            on-scroll-down = "shift_up";
          };
        };

        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            #children-class = "not-power";
            #transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/quit"
            "custom/hibernate"
            #"custom/lock"
            "custom/reboot"
          ];
        };

        "custom/power" = {
          format = "  ";
          tooltip = false;
          on-click = "shutdown now";
        };
        "custom/quit" = {
          format = "  ";
          tooltip = false;
          on-click = "hyprctl dispatch exit";
        };
        "custom/hibernate" = {
          format = "  ";
          tooltip = false;
          on-click = "systemctl hibernate";
        };
#        "custom/lock" = {
#          format = "  ";
#          tooltip = false;
#          on-click = "swaylock";
#        };
        "custom/reboot" = {
          format = "  ";
          tooltip = false;
          on-click = "reboot";
        };

      };
    };

    style = ''
      ${catppuccinColors}

      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
      }
  
      window#waybar {
          background-color: alpha(@base, 0.5);
          border-bottom: 3px solid alpha(@mantle, 0.5);
          color: @text;
          transition-property: background-color;
          transition-duration: .5s;
      }
  
      window#waybar.hidden {
          opacity: 0.2;
      }
      
       window#waybar.empty {
           background-color: @base;
       }
       window#waybar.solo {
           background-color: @surface1;
       }
  
      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }
  
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }
  
      #workspaces button {
          padding: 0 5px;
          background-color: @surface0;
          color: @text;
      }
      
      #workspaces button:hover {
          background: alpha(@overlay0, 0.2);
      }
      
      #workspaces button.focused {
          background-color: @overlay1;
          box-shadow: inset 0 -3px @text;
      }
      
      #workspaces button.urgent {
          background-color: @overlay2;
      }

      #workspaces button sub {
          background-color: @surface1;
      }

      #workspaces button.active {
          background-color: alpha(@mauve, 0.2);
      }
      
      #mode {
          /* what is this? */
          background-color: rgb(255,0,0);
          border-bottom: 3px solid #ffffff;
      }
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #mpd {
          padding: 0 10px;
          color: @subtext1;
      }
      
      #window,
      #workspaces {
          margin: 0 4px;
      }
      
      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }
      
      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }
      
      #clock {
          background-color: @surface1;
      }
      
      #battery {
          background-color: @surface1;
          color: @subtext1;
      }
      
      #battery.charging, #battery.plugged {
          color: @subtext1;
          background-color: @surface1;
      }
      
      @keyframes blink {
          to {
              background-color: @surface1;
              color: @subtext1;
          }
      }
      
      #battery.critical:not(.charging) {
          background-color: @surface1;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      label:focus {
          background-color: @overlay0;
      }
      
  /*
      #cpu {
          background-color: #2ecc71;
      color: #000000;
      }
      
      #memory {
          background-color: #9b59b6;
      }
      
      #disk {
          background-color: #964B00;
      }
  */
      
      #backlight {
          background-color: @surface1;
      }
      
      #network {
          background-color: @surface1;
      }
      
      #network.disconnected {
          background-color: alpha(@surface1, 0.5);
      }
      
      #pulseaudio {
          background-color: @surface1;
          color: @subtext1;
      }
      
      #pulseaudio.muted {
          background-color: alpha(@surface1, 0.5);
          color: @subtext1;
      }
      
      #wireplumber {
          background-color: @surface1;
          color: @subtext1;
      }
      
      #wireplumber.muted {
          background-color: alpha(@surface1, 0.5);
          color: @subtext1;
      }
      
  /*
      #custom-media {
          background-color: #66cc99;
      color: #2a5c45;
             min-width: 100px;
      }
      
      #custom-media.custom-spotify {
          background-color: #66cc99;
      }
      
      #custom-media.custom-vlc {
          background-color: #ffa000;
      }
  */
      
      #temperature {
          background-color: #f0932b;
      }
      
      #temperature.critical {
          background-color: #eb4d4b;
      }
      
      #tray {
          background-color: @surface2;
      }
      
      #tray > .passive {
          -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @overlay2;
      }
      
  /*
      #idle_inhibitor {
          background-color: #2d3436;
      }
      
      #idle_inhibitor.activated {
          background-color: #ecf0f1;
      color: #2d3436;
      }
      
      #mpd {
          background-color: #66cc99;
      color: #2a5c45;
      }
      
      #mpd.disconnected {
          background-color: #f53c3c;
      }
      
      #mpd.stopped {
          background-color: #90b1b1;
      }
      
      #mpd.paused {
          background-color: #51a37a;
      }
  */
      
      #language {
      background: @surface0;
      color: @text;
      padding: 0 5px;
      margin: 0 5px;
              min-width: 16px;
      }
      
      #keyboard-state {
      background: @surface0;
      color: @text;
      padding: 0 0px;
      margin: 0 5px;
              min-width: 16px;
      }
      
      #keyboard-state > label {
      padding: 0 5px;
      }
      
      #keyboard-state > label.locked {
      background: rgba(0, 0, 0, 0.2);
      }
      
      #scratchpad {
      background: rgba(0, 0, 0, 0.2);
      }
      
      #scratchpad.empty {
          background-color: transparent;
      }
    '';
  };
}
