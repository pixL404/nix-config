{
  pkgs,
  inputs,
  ...
}:
let
  catppuccin-sddm = inputs.sddm-catppuccin.packages.${pkgs.hostPlatform.system}.sddm-catppuccin;
in
{
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-policykit
    qt6.qtwayland
    libsForQt5.qt5.qtwayland

    firefox
  
    xdg-desktop-portal-gtk
    cliphist
    wl-clipboard
    catppuccin-sddm

    libsecret
  ];
}
