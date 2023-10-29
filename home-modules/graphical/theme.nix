{
  pkgs,
  home-manager,
  ...
}:
{
  gtk = {
    enable = true;
    theme = {
      name = "Catpuccin-Frappe-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        variant = "frappe";
      };
    };
    cursorTheme = {
      package = pkgs.catppuccin-cursors.frappeDark;
      name = "Catpuccin-Frappe-Dark";
      size = 32;
    };
  };
  
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "Catpuccin-Frappe-Dark";
    size = 32;
  };
}
