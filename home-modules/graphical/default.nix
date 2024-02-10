{
  config,
  pkgs,
  monitors,
  keyboard,
  inputs,
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
      inputs = inputs;
    })
    ./waybar

    ./foot.nix
    ./vscode.nix
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/data/music";
  };
  services.mpd-mpris.enable = true;
  services.mpris-proxy.enable = true;
}
