{ config, pkgs, ...}:

{

  imports = [
    ./hyprland.nix
  ];

  home.username = "alex";

  home.stateVersion = "23.11";

  programs.git = {
    enable = true;
    userName = "alex";
    userEmail = "alexostresso@gmail.com";
  };
}
