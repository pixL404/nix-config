{
  colors ? "",
  monitors ? "",
  keyboard ? "",
  ...
}:
''
${colors}

# See https://wiki.hyprland.org/Configuring/Monitors/
${monitors}

# obligatory autodetect:
monitor = , preferred, auto, 1, mirror, eDP-1

# See https://wiki.hyprland.org/Configuring/Keywords/ for more

# Execute your favorite apps at launch
exec-once = waypaper --restore --backend swww &
exec-once = dunst &
exec-once = waybar &
exec-once = foot --server &
exec-once = lxqt-policykit-agent &
exec-once = solaar-cli -w hide &
exec-once = blueman-applet &

#Stores only text data
exec-once = wl-paste --type text --watch cliphist store 
#Stores only image data
exec-once = wl-paste --type image --watch cliphist store 

# Some default env vars.
env = XCURSOR_SIZE,20
env = WLR_DRM_NO_ATOMIC,1
# env = XDG_SCREENSHOTS_DIR,$XDG_PICTURES_DIR/Screenshots

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    follow_mouse = 2
    float_switch_override_focus = 2

    touchpad {
        natural_scroll = yes
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

device:logitech-mx-master-2s-1 {
    accel_profile = flat

    sensitivity = 0
}
device:mx-master-2s-mouse {
    accel_profile = flat

    sensitivity = 0
}

${keyboard} {
    kb_layout = us
    kb_options = caps:escape
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 20
    border_size = 2
    #col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.active_border = $lavender $maroon 45deg
    col.inactive_border = $overlay0

    allow_tearing = true

    layout = master
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10
    
    blur {
        enabled = true
        size = 3
        passes = 1
    }

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = false

}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = on
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device:epic-mouse-v1 {
    sensitivity = -0.5
}

# Window Rules

windowrule = float, lxqt-policykit-agent

# fake fullscreen for vs-code to hide custom bar
windowrulev2 = fakefullscreen, class:^(code-url-handler)$

# float file and folder dialog
windowrulev2 = float, title:((o|O)pen ((f|F)ile|(f|F)older))
windowrulev2 = float, title:((s|S)ave ((f|F)ile|(f|F)older))

# steam friends list floating
windowrulev2 = float, title:Friends List

# allow tearing for certain applications:
windowrulev2 = immediate, class:^(cs2)$
windowrulev2 = fullscreen, class:^(cs2)$
windowrulev2 = immediate, class:^(Minecraft)

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, T, exec, footclient
# bind = $mainMod, T, exec, xfce4-terminal
bind = $mainMod, BACKSPACE, killactive, 
bind = $mainMod, M, exit, 
bind = $mainMod, V, togglefloating 
bind = $mainMod, Return, exec, wofi --show drun
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, O, togglesplit, # dwindle

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d
# Move focus with mainMod + H J K L
bind = $mainMod, H, movefocus, l
bind = $mainMod, J, movefocus, d
bind = $mainMod, K, movefocus, u
bind = $mainMod, L, movefocus, r

# Move window with mainMod CTRL + arrow keys
bind = $mainMod CTRL, left, movewindow, l
bind = $mainMod CTRL, right, movewindow, r
bind = $mainMod CTRL, up, movewindow, u
bind = $mainMod CTRL, down, movewindow, d
# Move window with mainMod CTRL + H J K L
bind = $mainMod CTRL, H, movewindow, l
bind = $mainMod CTRL, J, movewindow, d
bind = $mainMod CTRL, K, movewindow, u
bind = $mainMod CTRL, L, movewindow, r
 
# behaves like xmonads promote feature (https://hackage.haskell.org/package/xmonad-contrib-0.17.1/docs/XMonad-Actions-Promote.html)
bind= $mainMod, P, layoutmsg, swapwithmaster 

# switch to last window (or urgent) with mainMod, TAB
bind = $mainMod, TAB, focusurgentorlast

# scratchpad
bind = $mainMod, ESCAPE, movetoworkspace, special
bind = $mainMod SHIFT, ESCAPE, togglespecialworkspace

# Switch workspaces with mainMod + [0-9]
# Move active window to a workspace with mainMod + SHIFT + [0-9]
${builtins.concatStringsSep "\n" (builtins.genList (
  x: let
    ws = let
      c = (x + 1) / 10;
    in
      builtins.toString (x + 1 - (c * 10));
  in ''
    bind = $mainMod, ${ws}, workspace, ${toString (x + 1)}
    bind = $mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}''
)
10)}

# cycle next or last workspace with pageup/pagedown
bind = $mainMod, NEXT, workspace, r+1
bind = $mainMod, PRIOR, workspace, r-1

# move active window to next or last workspace with pageup/pagedown
bind = $mainMod SHIFT, NEXT, movetoworkspace, r+1
bind = $mainMod SHIFT, PRIOR, movetoworkspace, r-1


# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# float and pin window on mainMod + SHIFT + Middle Mouse click
bind = $mainMod SHIFT, mouse:274, exec, hyprctl --batch " dispatch togglefloating ; dispatch pin "

# "zoom" mode
bind = $mainMod, equal, exec, hyprctl --batch "keyword general:gaps_out 0 ; keyword general:gaps_in 2 ; keyword general:border_size 1 ; keyword monitor ,addreserved,5,0,0,0"

# reload config (to reset e.g. zoom mode)
bind = $mainMod SHIFT, R, exec, hyprctl reload

# will switch to a submap called resize
bind= $mainMod, R, submap, resize

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

# screenshots
# like snipping tool
bind = $mainMod SHIFT, S, exec, grimblast --notify copy area
# copy current window to clipboard
bind = , PRINT, exec, grimblast --notify copysave active

# show clipboard history and copy selection
bind = $mainMod SHIFT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

# laptop binds
bind =, XF86MonBrightnessDown, exec, brightnessctl --class backlight set 5%- -q -n 5%
bind =, XF86MonBrightnessUp, exec, brightnessctl --class backlight set 5%+ -q

# audio binds
bind =, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
bind =, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
bind =, XF86AudioMute, exec, wpctl  set-mute @DEFAULT_AUDIO_SINK@ toggle
bind =, XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

''
