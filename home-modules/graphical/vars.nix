{ lib, ... }:
with lib;
let
  resolutionType = types.strMatching "[[:digit:]]+x[[:digit:]]+";
  monitor = types.submodule {
    options = {
      name = mkOption {
        description = "Input of the primary monitor, eg DP-1";
        type = types.str;
      };

      resolution = mkOption {
        description = "resolution to use";
        type = types.either (types.enum [
          "preferred"
          "highres"
          "highrr"
        ]) resolutionType;
      };

      refresh_rate = mkOption {
        description = "max refresh rate of the monitor";
        type = types.ints.unsigned;
      };

      position = mkOption {
        description = "offset from 0x0 (positive -> right/down)";
        type = types.either (types.enum [
          "auto"
          "auto-left"
          "auto-right"
          "auto-up"
          "auto-down"
        ]) resolutionType;
        default = "0x0";
      };

      scaling = mkOption {
        description = "monitor scaling";
        type = types.float;
        default = 1;
      };

      orientation = mkOption {
        description = "default placement of the master area";
        type = types.enum [
          "left"
          "right"
          "top"
          "bottom"
          "center"
        ];
      };

      misc = mkOption {
        description = "list of hyprland definitions to add";
        type = types.listOf types.str;
        default = [ ];
      };
    };
  };
in
{
  options.hardwareConf = {
    keyboard = mkOption {
      description = "name of the physical keyboard shown by `hyprctl devices`";
      type = types.str;
    };

    monitors = mkOption {
      description = "attrs defining monitor layout";
      type = types.submodule {
        options = {
          primary = mkOption {
            description = "primary monitor, used for settings like max fps and such";
            type = monitor;
          };

          other = mkOption {
            description = "list of other monitors";
            type = types.listOf monitor;
          };
        };
      };
    };
  };

}
