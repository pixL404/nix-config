{
  config,
  pkgs,
  inputs,
  ...
}:
let
  # monitors = "monitor = eDP-1, preferred, auto, 1";
  monitors = {
    primary = {
      name = "eDP-1";
      resolution = "1920x1080";
      refresh_rate = 60;
      position = "auto";
      scaling = 1.0;
    };
    other = [ ];
  };
  keyboard = "at-translated-set-2-keyboard";
in
{
  imports = [
    ../../home-modules/common

    (import ../../home-modules/graphical {
      inherit
        monitors
        keyboard
        pkgs
        inputs
        config
        ;
    })
  ];
}
