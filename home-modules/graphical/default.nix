{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./packages.nix

    ./theme.nix

    ./hyprland
    ./waybar

    ./foot.nix
    ./vscode.nix
  ];
  
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}