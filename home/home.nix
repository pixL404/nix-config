{ config, pkgs, ...}:

{

  imports = [
    ./hyprland.nix
    ./fish.nix
    ./foot.nix
    ./waybar.nix

    ./theme.nix
  ];

  home.username = "alex";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs

    brightnessctl
    libnotify
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
