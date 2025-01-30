{
  pkgs,
  lib ? pkgs.lib,
  osConfig,
  ...
}:
let
  enable-hdr = pkgs.writeShellApplication {
    name = "enable-hdr";
    runtimeInputs = with pkgs; [
      hyprland
      gawk
      coreutils
    ];
    text = ''
      HDR_STATUS=$(hyprctl getoption experimental:hdr | awk '{print $2}' | head -n 1)

      if [[ $HDR_STATUS = 0 ]]; then
        notify-send "enabling HDR"
        hyprctl keyword experimental:wide_color_gamut true
        hyprctl keyword experimental:hdr true
      else
        notify-send "disabling HDR"
        hyprctl keyword experimental:wide_color_gamut false
        hyprctl keyword experimental:hdr false
      fi
    '';
  };
in
[
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
  (builtins.concatStringsSep "\n" (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      ''
        bind = $mainMod, ${ws}, workspace, ${toString (x + 1)}
        bind = $mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}''
    ) 10
  ))

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

  # media binds
  ", XF86AudioPrev, exec, playerctl previous"
  ", XF86AudioPlay, exec, playerctl play-pause"
  ", XF86AudioNext, exec, playerctl next"

  # screen lock
  "$mainMod ALT, L, exec, hyprlock"

  # enable HDR only on desktop
  (lib.mkIf (osConfig.networking.hostName == "wanda") "$mainMod ALT, H, exec, ${enable-hdr}/bin/enable-hdr")
]
