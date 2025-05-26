{
  config,
  pkgs,
  lib,
  inputs',
  self',
  ...
}:
let
  catppuccin-sddm = inputs'.sddm-catppuccin.packages.default;
in
{
  environment.systemPackages =
    with pkgs;
    lib.mkIf config.custom.enableGraphical [
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
      self'.packages.indicator-application-gtk3
    ];
}
