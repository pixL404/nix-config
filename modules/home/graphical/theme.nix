{
  config,
  pkgs,
  lib,
  inputs,
  inputs',
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
        # gtk.enable = true;
        kvantum.enable = true;
        hyprland.enable = true;
        foot.enable = true;
        dunst.enable = true;

        vscode.profiles.default.settings = {
          accent = "lavender";
          boldKeywords = true;
          bracketMode = "rainbow";
          italicComments = true;
          italicKeywords = true;
          extraBordersEnabled = false;
          workbenchMode = "default";
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

      home = {
        sessionVariables.HYPRCURSOR_THEME = "McMojave";
        sessionVariables.HYPRCURSOR_SIZE = 32;
        packages = [
          inputs'.mcmojave-hyprcursor.packages.default
        ];

        pointerCursor = {
          hyprcursor.enable = true;
          gtk.enable = true;
          package = inputs'.mcmojave-hyprcursor.packages.default;
          name = "McMojave";
          size = 32;
        };
      };
    };
  };
}
