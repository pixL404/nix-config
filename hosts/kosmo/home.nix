{
  config,
  pkgs,
  inputs,
  ...
}:
let
  monitors = "monitor = eDP-1, preferred, auto, 1";
  keyboard = "at-translated-set-2-keyboard";
in
{
  imports = [
    inputs.hyprlock.homeManagerModules.default

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