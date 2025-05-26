{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.custom;
in
{
  hm = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];
    config = lib.mkIf cfg.enableGraphical {
      # import the nixosModule when we're running on NixOS
      # the homeManager module will get loaded into HM from /modules/home/default

      catppuccin = {
        enable = true;
        flavor = "frappe";
        accent = "lavender";

        #programs
        waybar.enable = true;
        gtk.enable = true;
        kvantum.enable = true;
        hyprland.enable = true;
        foot.enable = true;
        dunst.enable = true;

        vscode = {
          accent = "lavender";
          settings = {
            boldKeywords = true;
            bracketMode = "rainbow";
            italicComments = true;
            italicKeywords = true;
            extraBordersEnabled = false;
            workbenchMode = "default";
          };
        };
      };

      gtk = {
        enable = true;
        font = {
          name = "Sans";
          size = 11;
        };
      };

      qt = {
        enable = true;
        style.name = "kvantum";
        platformTheme.name = "kvantum";
      };

      home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.pantheon.elementary-gtk-theme;
        name = "elementary";
        size = 24;
      };
    };
  };
}
