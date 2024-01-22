{
  pkgs,
  ...
}:
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
          name = "fix waybar wlr/workspace clicking";
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
        spacing = 0; # set in css
        margin = "0";
#        height = 30; 

        modules-left = [ "hyprland/workspaces" ];

        modules-center = [ "wlr/taskbar" ];

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
          active-only = false;
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "active" = "";
            "default" = "";
          };
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
        };
          
        "wlr/taskbar" = {
            format = "{icon}";
            icon-size = 20;
            # icon-theme = "Numix-Circle";
            tooltip-format = "{title}";
            on-click = "activate";
            on-click-middle = "close";
        };

        "tray" = {
          icon-size = 16;
          spacing = 4;
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
            children-class = "not-power";
            transition-left-to-right = false;
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
          format = " {} ";
          tooltip = true;
          on-click = "shutdown now";
          interval = "once";
          exec = "echo '\npower off'";
          exec-on-event = false;
        };
        "custom/quit" = {
          format = " {} ";
          tooltip = true;
          on-click = "hyprctl dispatch exit";
          interval = "once";
          exec = "echo '\nquit'";
          exec-on-event = false;
        };
        "custom/hibernate" = {
          format = " {} ";
          tooltip = true;
          on-click = "systemctl hibernate";
          interval = "once";
          exec = "echo '\nhibernate'";
          exec-on-event = false;
        };
#        "custom/lock" = {
#          format = " {} ";
#          tooltip = true;
#          on-click = "swaylock";
#          interval = "once";
#          exec = "echo '\nlock'";
#          exec-on-event = false;
#        };
        "custom/reboot" = {
          format = " {} ";
          tooltip = true;
          on-click = "reboot";
          interval = "once";
          exec = "echo '\nreboot'";
          exec-on-event = false;
        };

      };
    };

    style = import ./style.nix { colors = catppuccinColors; };
  };
}