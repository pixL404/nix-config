{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs

    libnotify

    # is this only working for laptop integrated monitors?
    brightnessctl

    spotify
    playerctl

    waypaper
    swww
    swaybg
    wofi
    dunst

    lxqt.pavucontrol-qt


    # myxer # from overlay
  ];
}
