{ pkgs, inputs, ... }:
let
  catppuccin-sddm = inputs.sddm-catppuccin.defaultPackage.${pkgs.hostPlatform.system};
in
{
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-policykit
    qt6.qtwayland
    libsForQt5.qt5.qtwayland

    firefox

    # office suite
    libreoffice
    onlyoffice-desktopeditors
    hunspell
    hunspellDicts.de_AT
    hunspellDicts.en_US

    xdg-desktop-portal-gtk
    cliphist
    wl-clipboard
    catppuccin-sddm

    libsecret

    pantheon-tweaks
    indicator-application-gtk3 # from overlay
  ];
}
