{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefox

    libnotify

    # is this only working for laptop integrated monitors?
    brightnessctl
  ];
}