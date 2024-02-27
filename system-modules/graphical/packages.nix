{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-policykit
    qt6.qtwayland
    libsForQt5.qt5.qtwayland

    firefox
  
    xdg-desktop-portal-gtk
    cliphist
    wl-clipboard
    sddm-chili-theme

    libsecret
  ];
}
