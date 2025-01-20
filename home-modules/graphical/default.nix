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
    ./lxqt.nix

    ./theme.nix

    (import ./hyprland { inherit pkgs inputs monitors keyboard; })

    ./hyprpanel
    ./waybar

    ./foot.nix
    ./vscode.nix

    # catppuccin module
    inputs.catppuccin.homeManagerModules.catppuccin

    ./obs-studio

    (import ./mangohud.nix { inherit pkgs monitors ; })
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/data/music";
  };
  services.mpd-mpris.enable = true;
  services.mpris-proxy.enable = true;

  # open source rich presence server
  services.arrpc.enable = true;

  # audio mixer for pipewire
  services.easyeffects.enable = true;

  # notification service
  services.dunst.enable = false;
}
