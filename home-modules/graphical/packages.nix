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

    gnome.nautilus
    gnome.file-roller

    # is this only working for laptop integrated monitors?
    brightnessctl
  ];
}