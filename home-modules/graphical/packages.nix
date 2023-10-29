{
  pkgs,
  home-manager,
  ...
}:
{
  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs

    libnotify

    # is this only working for laptop integrated monitors?
    brightnessctl
  ];
}