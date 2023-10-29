{
  config,
  pkgs,
  home-manager,
  ...
}:
{
  imports = [
    ./fish.nix
  ];

  home.username = "alex";

  home.stateVersion = "23.11";

  # TODO: adjust for work wsl home-flake in the future
  programs.git = {
    enable = true;
    userName = "alex";
    userEmail = "alexostresso@gmail.com";
  };
  programs.zellij = {
    enable = true;
  };
}