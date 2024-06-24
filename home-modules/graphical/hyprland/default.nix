{
  pkgs,
  inputs,
  monitors,
  keyboard,
  ...
}:
{
  # hypr-contrib packages
  home.packages = with inputs.hyprland-contrib.packages.${pkgs.system}; [
    grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # plugins = with inputs.hyprland-contrib.packages.${pkgs.system}; [
    # ];

    sourceFirst = true;
    settings = {
      
      source = "${pkgs.hyprland-catppuccinColors}";

      monitor = [
        monitors
        # autodetect
        ", preferred, auto, 1"
      ];

      exec-once = [
        "waypaper --restore --backend swww"
        "dunst"
        "waybar"
        "foot --server"
        "lxqt-policykit-agent"
        "solaar-cli -w hide"
        "blueman-applet"

        "vivaldi"
        "steam"
        "vesktop"

        # clipboard
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      env = [
        "XCURSOR_SIZE,20"
        "XCURSOR_THEME,elementary"
        "GTK_THEME,Catppuccin-Frappe-Standard-Lavender-Dark"

        "WLR_DRM_NO_ATOMIC,1" # allow tearing

        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland" #disable if games give error
        "CLUTTER_BACKEND,wayland"

        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      input = {
        follow_mouse = 2;
        float_switch_override_focus = 2;

        touchpad = {
          natural_scroll = true;
        };

        # from -1.0 to 1.0
        sensitivity = 0.0;
      };

      device = [
        {
          name = "logitech-mx-master-2s-1";
          accel_profile = "flat";

          sensitivity = -0.75;
        }

        {
          name = "logitech-mx-master-2s-mouse";
          accel_profile = "flat";

          sensitivity = -0.75;
        }

        {
          name = keyboard;
          kb_layout = "us";
          kb_options = "caps:escape,compose:menu";
        }
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        "col.active_border" = "$lavender $maroon 45deg";
        "col.inactive_border" = "$overlay0";

        allow_tearing = true;

        layout = "master";
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = false;
      };

      gestures = {
        workspace_swipe = true;
      };

      windowrulev2 = [
        "float, class:^(lxqt-policykit-agent)"

        # fake fullscreen for vs-code to hide custom bar
        "fakefullscreen, class:^(code-url-handler)$"

        # float file and folder dialog
        "float, title:((o|O)pen ((f|F)ile|(f|F)older))"
        "float, title:((s|S)ave ((f|F)ile|(f|F)older))"

        # steam friends list floating
        "float, title:Friends List"

        # allow tearing
        "immediate, class:^(cs2)$"
        "fullscreen, class:^(cs2)$"
        "immediate, class:^(Minecraft)"
        "immediate, title:^(TEKKEN)"

        # atuostart applications
        "workspace 1 silent, title:^(Steam)$"
        "workspace 2 silent, class:^(vivaldi-stable)$"
        "workspace 2 silent, class:^(vesktop)$"
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, T, exec, footclient"
        "= $mainMod, T, exec, xfce4-terminal"
        "$mainMod, BACKSPACE, killactive, "
        "$mainMod, M, exit, "
        "$mainMod, V, togglefloating "
        "$mainMod, Return, exec, wofi --show drun"
        "$mainMod, P, pseudo, " # dwindle"
        "$mainMod, O, togglesplit, " # dwindle"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        # Move focus with mainMod + H J K L
        "$mainMod, H, movefocus, l"
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"
        "$mainMod, L, movefocus, r"

        # Move window with mainMod CTRL + arrow keys
        "$mainMod CTRL, left, movewindow, l"
        "$mainMod CTRL, right, movewindow, r"
        "$mainMod CTRL, up, movewindow, u"
        "$mainMod CTRL, down, movewindow, d"
        # Move window with mainMod CTRL + H J K L
        "$mainMod CTRL, H, movewindow, l"
        "$mainMod CTRL, J, movewindow, d"
        "$mainMod CTRL, K, movewindow, u"
        "$mainMod CTRL, L, movewindow, r"

        # behaves like xmonads promote feature (https://hackage.haskell.org/package/xmonad-contrib-0.17.1/docs/XMonad-Actions-Promote.html)
        "$mainMod, P, layoutmsg, swapwithmaster "

        # switch to last window (or urgent) with mainMod, TAB
        "$mainMod, TAB, focusurgentorlast"

        # scratchpad
        "$mainMod, ESCAPE, movetoworkspace, special"
        "$mainMod SHIFT, ESCAPE, togglespecialworkspace"

        # maximize window (still show bar)
        "$mainMod, f, fullscreen, 1"
        # actual fullscreen
        "$mainMod SHIFT, f, fullscreen, 0"
        ", f11, fullscreen, 0"

        # Switch workspaces with mainMod + [0-9]
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        (builtins.concatStringsSep "\n" (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $mainMod, ${ws}, workspace, ${toString (x + 1)}
            bind = $mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}''
        )
        10))

        # cycle next or last workspace with pageup/pagedown
        "$mainMod, NEXT, workspace, r+1"
        "$mainMod, PRIOR, workspace, r-1"

        # move active window to next or last workspace with pageup/pagedown
        "$mainMod SHIFT, NEXT, movetoworkspace, r+1"
        "$mainMod SHIFT, PRIOR, movetoworkspace, r-1"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # float and pin window on mainMod + SHIFT + Middle Mouse click
        ''$mainMod SHIFT, mouse:274, exec, hyprctl --batch " dispatch togglefloating ; dispatch pin "''

        # "zoom" mode
        ''$mainMod, equal, exec, hyprctl --batch "keyword general:gaps_out 0 ; keyword general:gaps_in 2 ; keyword general:border_size 1 ; keyword monitor ,addreserved,5,0,0,0"''

        # reload config (to reset e.g. zoom mode)
        "$mainMod SHIFT, R, exec, hyprctl reload"

        # screenshots
        # like snipping tool
        "$mainMod SHIFT, S, exec, grimblast --notify copy area"
        # copy screen to clipboard
        ", PRINT, exec, grimblast --notify copy screen"
        # copy current window to clipboard and save
        "$mainMod, PRINT, exec, grimblast --notify copysave active"

        # show clipboard history and copy selection
        "$mainMod SHIFT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

        # laptop binds
        ", XF86MonBrightnessDown, exec, brightnessctl --class backlight set 5%- -q -n 5%"
        ", XF86MonBrightnessUp, exec, brightnessctl --class backlight set 5%+ -q"

        # audio binds
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl  set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # screen lock
        "$mainMod ALT, L, exec, hyprlock"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

    };
    extraConfig = ''
      # will start a submap called "resize"
      submap= resize

      # sets repeatable binds for resizing the active window
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10

      # use reset to go back to the global submap
      bind = , escape, submap, reset 

      # will reset the submap, meaning end the current one and return to the global one
      submap = reset
    '';
  };

  # programs.hyprlock = {
  #   enable = true;
  # };

}
