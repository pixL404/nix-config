{
  pkgs,
  ...
}:
let
  catppuccinColors = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/hyprland/99a88fd21fac270bd999d4a26cf0f4a4222c58be/themes/frappe.conf";
    hash = "sha256-knpSjUKtQ1tsOotTi/e+OMdHCchgBI3tSa148dF3UqA=";
  });
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    #disableAutoReload = false;
    extraConfig = import ./config.nix { colors = catppuccinColors; };
    xwayland.enable = true;
  };
}
