{ config, pkgs, ... }:
let
  customConf = builtins.readFile ./configs/hyprland/hyprland.conf;
  catpuccinColors = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/hyprland/99a88fd21fac270bd999d4a26cf0f4a4222c58be/themes/frappe.conf";
    hash = "sha256-knpSjUKtQ1tsOotTi/e+OMdHCchgBI3tSa148dF3UqA=";
  });
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    #disableAutoReload = false;
    extraConfig = ''
      ${catpuccinColors}

      ${customConf}

      # create default 5 workspaces
      ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          workspace = ${toString (x + 1)}
        ''
      )
      5)}
    '';
    xwayland.enable = true;
  };
}
