{
  config,
  pkgs,
  inputs,
  ...
}:
let
  monitors = "monitor = HDMI-A-1, preferred, auto, 1";
  keyboard = "device:chicony-usb-keyboard";
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default

    ../../home-modules/common

    (import ../../home-modules/graphical {
      monitors = monitors;
      keyboard = keyboard;
      pkgs = pkgs;
      inputs = inputs;
      config = config;
    })
  ];
}