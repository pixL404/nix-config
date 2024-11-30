{
  config,
  pkgs,
  inputs,
  ...
}:
let
  # monitors = "HDMI-A-2, 1920x1080@76, auto, 1";
  monitors = {
    primary = {
      name = "HDMI-A-2";
      resolution = "1920x1080";
      refresh_rate = "76";
      position = "auto";
      scaling = "1";
    };
    other = [ ];
  };
  keyboard = "chicony-perixx-ergo-keyboard";
in
{
  imports = [
    ../../home-modules/common

    (import ../../home-modules/graphical
      { inherit monitors keyboard pkgs inputs config; }
    )
  ];
}
