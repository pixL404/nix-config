{
  lib,
  ...
}:
with lib;
let
  resolutionType = types.strMatching "[[:digit:]]+x-?[[:digit:]]+";
  monitorType.options = {
    name = mkOption {
      description = "Input of the primary monitor, eg DP-1";
      type = types.str;
      default = "";
    };

    resolution = mkOption {
      description = "resolution to use";
      type = types.either (types.enum [
        "preferred"
        "highres"
        "highrr"
      ]) resolutionType;
      default = "preferred";
    };

    refresh_rate = mkOption {
      description = "max refresh rate of the monitor";
      type = types.ints.unsigned;
      default = 60;
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
      default = "left";
    };

    misc = mkOption {
      description = "list of hyprland definitions to add";
      type = types.listOf types.str;
      default = [ ];
    };
  };
in
{
  options.graphical.hyprland = {
    enable = mkEnableOption "custom hyprland module on top of home-manager module";

    enableLock = mkEnableOption "screen locking";

    keyboard = mkOption {
      description = "name of the physical keyboard shown by `hyprctl devices`";
      type = types.str;
    };

    monitors = {
      primary = mkOption {
        description = "primary monitor, used for settings like max fps and such";
        type = types.submodule monitorType;
        default = { };
      };

      other = mkOption {
        description = "list of other monitors";
        type = types.listOf (types.submodule monitorType);
        default = [ ];
      };
    };
  };
}
