{
  pkgs,
  lib ? pkgs.lib,
  monitors,
  ...
}:
let
  create_monitor_string = {
    name ? "",
    resolution ? "preferred",
    refresh_rate ? "",
    position ? "auto",
    scaling ? "1" # this has to be a string
  }:
  (
    let
      res_and_refresh = if refresh_rate != "" && resolution != "preferred"
        then "${resolution}@${refresh_rate}"
        else "preferred";
    in
      builtins.concatStringsSep ", " [name res_and_refresh position scaling]
  );
in
lib.mkMerge [
  # other monitors
  ( builtins.map create_monitor_string monitors.other )

  [
    # primary monitor
    (create_monitor_string monitors.primary)

    # autodetect
    ", preferred, auto, 1"
  ]
]