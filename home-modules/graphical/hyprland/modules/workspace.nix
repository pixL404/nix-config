{
  pkgs,
  lib ? pkgs.lib,
  monitors,
  ...
}:
let
  primaryName = monitors.primary.name;
  multipleMonitors = (builtins.length monitors.other) > 0;
  secondary = if multipleMonitors then builtins.head monitors.other else null;
in
lib.mkMerge [
  [
    "1, monitor:${primaryName}"
    "2, monitor:${primaryName}"
  ]

  (lib.mkIf (multipleMonitors) [
    "3, monitor:${secondary.name}"
    "4, monitor:${secondary.name}"

    "m[${secondary.name}], layoutopt:orientation:${secondary.orientation}"
  ])

]