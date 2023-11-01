{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.hyprland.homeManagerModules.default

    ../../home-modules/common

    ../../home-modules/graphical
  ];
}