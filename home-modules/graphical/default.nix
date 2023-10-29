{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./packages.nix

    ./theme.nix

    ./hyprland.nix
    ./waybar.nix
    ./foot.nix
    ./vscode.nix
  ];
}