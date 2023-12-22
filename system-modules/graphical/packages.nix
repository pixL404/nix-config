{
  pkgs,
  # catppuccin-sddm,
  ...
}:
#let
#  catppuccin-sddm-frappe = import catppuccin-sddm.packages."${pkgs.system}".catppuccin-frappe;
#in
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
  ];
#  ++
#  [
#    (catppuccin-sddm-frappe {
#      font = "Helvetica Neue";
#      fontSize = 11;
#      clockEnabled = true;
#      customBackground = false;
#      loginBackground = false;
#      background = "https://raw.githubusercontent.com/Gingeh/wallpapers/main/minimalistic/dark-cat-rosewater.png";
#    })
#  ];
}
