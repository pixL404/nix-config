{
  pkgs,
  home-manager,
  ...
}:
{
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "lavender";
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      cursor.enable = false;
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  qt = {
    enable = true;
    style.catppuccin.enable = true;
    platformTheme.name = "gtk3";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.pantheon.elementary-gtk-theme;
    name = "elementary";
    size = 16;
  };
}
