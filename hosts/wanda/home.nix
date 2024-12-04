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
      name = "DP-2";
      resolution = "2560x1440";
      refresh_rate = "180";
      position = "1920x0";
      scaling = "1";
      misc = [
        "bitdepth, 10"
        "vrr, 2" # vrr 2 => fullscreen only
      ]; 
    };
    other = [
      {
        name = "HDMI-A-2";
        resolution = "1920x1080";
        refresh_rate = "76";
        position = "0x0";
        scaling = "1";
      }
    ];
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
