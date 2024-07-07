{
  config,
  pkgs,
  inputs,
  ...
}:
let
  monitors = "HDMI-A-2, 1920x1080@76, auto, 1";
  keyboard = "chicony-perixx-ergo-keyboard";
in
{
  imports = [
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
