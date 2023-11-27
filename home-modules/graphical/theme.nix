{
  pkgs,
  home-manager,
  ...
}:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        variant = "frappe";
      };
      name = "Catppuccin-Frappe-Standard-Lavender-Dark";
    };
    iconTheme = {
      package = pkgs.libsForQt5.breeze-icons;
      name = "breeze-dark";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "Catppuccin-Frappe-Standard-Lavender-Dark";
  };
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Catpuccin-Frappe-Compact-Lavender-Dark";
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = [ "lavender" ];
  #       size = "compact";
  #       variant = "frappe";
  #     };
  #   };
  #   cursorTheme = {
  #     package = pkgs.catppuccin-cursors.frappeDark;
  #     name = "Catpuccin-Frappe-Dark";
  #     size = 16;
  #   };
  #   iconTheme = {
  #     name = "catppuccin-papirus-folders";
  #     package = pkgs.catppuccin-papirus-folders.override {
  #       accent = "lavender";
  #       flavor = "frappe";
  #     };
  #   };
  # };
  
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "Catpuccin-Frappe-Dark";
    size = 16;
  };
}
