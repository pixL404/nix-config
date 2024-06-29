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

    # catppuccin module
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/data/music";
  };
  services.mpd-mpris.enable = true;
  services.mpris-proxy.enable = true;

  # open source rich presence server
  services.arrpc.enable = true;

  # wayland notification service
  services.mako = {
    enable = true;
    layer = "overlay";
    defaultTimeout = 5;
  };
}
