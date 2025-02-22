{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs

    zen
    thunderbird-latest

    libnotify

    # is this only working for laptop integrated monitors?
    brightnessctl

    spotify
    playerctl

    waypaper
    swww
    swaybg
    wofi

    lxqt.pavucontrol-qt

    # open source discord client
    (vesktop.override {
      vencord = pkgs.vencord;
      withSystemVencord = true;
      electron = pkgs.electron_33;
    })


    mpv
  ];
}
