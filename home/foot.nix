{ pkgs, lib, ... }:
let
  catppuccinColors = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/4e5b4a78dec83b1778e01556f15cabd9c8c9ed4f/catppuccin-frappe.conf";
    hash = "sha256-5KjNdz4jpRzvB/UJjcMRBJYbTy4JHlUcfsiewo4ANME=";
  };
in
{
  programs.foot = {
    enable = true;
    server.enable = true;
  };

  xdg.configFile."foot/foot.ini".text = lib.generators.toINIWithGlobalSection {} {
    globalSection = {
      include = catppuccinColors;
    };
    sections = {
      main = {
        term = "foot";

        font = "monospace:size=11, font-awesome:size=11, emoji:size=11";
        dpi-aware = "no";

        pad = "4x4";

        bold-text-in-bright = "yes";
        selection-target = "both";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
      };

      scrollback = {
        indicator-format = "percentage";
      };

      cursor = {
        style = "block";
        blink = "no";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      colors = {
        alpha = 0.8;
      };

    };
  };
}
