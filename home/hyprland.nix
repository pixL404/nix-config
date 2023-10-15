{ config, pkgs, ... }:
let
  customConf = builtins.readFile ./configs/hyprland.conf;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = customConf;
  };
}
