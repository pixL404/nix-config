{
  config,
  pkgs,
  inputs,
  ...
}:
let
  monitors = "monitor = HDMI-A-2, 1920x1080@76, auto, 1";
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