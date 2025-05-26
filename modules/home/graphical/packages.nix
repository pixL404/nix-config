{
  pkgs,
  lib,
  config,
  self',
  ...
}:
{
  hm.config = lib.mkIf config.custom.enableGraphical {
    home.packages = with pkgs; [
      vivaldi
      vivaldi-ffmpeg-codecs

      thunderbird-latest

      libnotify

      brightnessctl

      spotify
      playerctl

      waypaper
      swww
      swaybg
      wofi

      lxqt.pavucontrol-qt

      # open source discord client
      vesktop

      signal-desktop

      mpv
      gimp

      kdePackages.okular
      file-roller
      gnome-commander
      self'.packages.zen
    ];
  };
}
