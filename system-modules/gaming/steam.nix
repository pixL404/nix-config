{
  config,
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    
    # enable gamescope for steam
    gamescopeSession.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    gamemode
  ];
}