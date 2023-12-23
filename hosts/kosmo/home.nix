{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.hyprland.homeManagerModules.default

    ../../home-modules/common

    ../../home-modules/graphical {
      monitors = "monitor = eDP-1, preferred, auto, 1";
      keyboard = "device:at-translated-set-2-keyboard";
    }
  ];
}