{
  pkgs,
  lib ? pkgs.lib,
  monitors,
  ...
}:
let
  create_monitor_string =
    monitor:
    let
      res_and_refresh =
        if monitor.refresh_rate != "" && monitor.resolution != "preferred" then
          "${monitor.resolution}@${builtins.toString monitor.refresh_rate}"
        else
          "preferred";
    in
    builtins.concatStringsSep ", " (
      [
        monitor.name
        res_and_refresh
        monitor.position
        (builtins.toString monitor.scaling)
      ]
      ++ monitor.misc
    );
in
lib.mkMerge [
  # other monitors
  (builtins.map create_monitor_string monitors.other)

  [
    # primary monitor
    (create_monitor_string monitors.primary)

    # autodetect
    ", preferred, auto, 1, mirror, ${monitors.primary.name}"
  ]
]
