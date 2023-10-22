{ config, pkgs, ...}:

{

  imports = [
    ./hyprland.nix
    ./fish.nix
  ];

  home.username = "alex";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs

    brightnessctl
  ];

  programs.git = {
    enable = true;
    userName = "alex";
    userEmail = "alexostresso@gmail.com";
  };
  programs.zellij = {
    enable = true;
  };
}
