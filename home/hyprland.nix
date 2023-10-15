{ config, pkgs, ... }:
let
  customConf = builtins.readFile ./configs/hyprland.conf;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    #disableAutoReload = false;
    extraConfig = customConf;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };
}
