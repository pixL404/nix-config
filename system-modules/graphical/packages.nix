{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-policykit
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    waypaper
    swww
    swaybg
    wofi
    dunst
  
    cliphist
    wl-clipboard

    catppuccin-sddm-corners
  ];
}