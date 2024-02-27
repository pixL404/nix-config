{
  pkgs,
  home-manager,
  ...
}:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk; # from overlay
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
  
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.pantheon.elementary-gtk-theme;
    name = "elementary";
    size = 16;
  };
}
