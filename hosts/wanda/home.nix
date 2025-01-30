{
  config,
  pkgs,
  inputs,
  ...
}:
{

  hardwareConf = {
    monitors = {
      primary = {
        name = "DP-2";
        resolution = "2560x1440";
        refresh_rate = 180;
        position = "1080x420"; # correct position to be next to vertical monitor
        scaling = 1.0;
        misc = [
          "bitdepth, 10"
          "vrr, 2" # vrr 2 => fullscreen only
        ];
      };
      other = [
        {
          name = "HDMI-A-2";
          resolution = "1920x1080";
          refresh_rate = 76;
          position = "0x0";
          scaling = 1.0;
          misc = [
            "transform, 1" # 90 degree rotate
          ];
          orientation = "top"; # top to bottom master layout
        }
      ];
    };
    keyboard = "chicony-perixx-ergo-keyboard";
  };

  imports = [
    ../../home-modules/common

    ../../home-modules/graphical
  ];
}
