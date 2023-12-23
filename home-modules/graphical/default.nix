{
  # config,
  pkgs,
  monitors,
  keyboard,
  ...
}:
{
  imports = [
    ./packages.nix

    ./theme.nix

    (import ./hyprland {
      monitors = monitors;
      keyboard = keyboard;
      pkgs = pkgs;
    })
    ./waybar

    ./foot.nix
    ./vscode.nix
  ];
  
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
