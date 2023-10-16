{ config, pkgs, ...}:

{

  imports = [
    ./hyprland.nix
    ./fish.nix
  ];

  home.username = "alex";

  home.stateVersion = "23.11";

  programs.git = {
    enable = true;
    userName = "alex";
    userEmail = "alexostresso@gmail.com";
  };
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };
}
