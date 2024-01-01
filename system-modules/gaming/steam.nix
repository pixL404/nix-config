{
  config,
  pkgs,
  ...
}:
{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    gamemode
  ];
}