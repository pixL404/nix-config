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
    pointerCursor.enable = false;
  };

  gtk = {
    enable = true;
    catppuccin.enable = true;
    font = {
      name = "Sans";
      size = 11;
    };
  };

  qt = {
    enable = true;
    style.catppuccin.enable = true;
    style.catppuccin.accent = "blue";
    # in order to use catppuccin theme
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.pantheon.elementary-gtk-theme;
    name = "elementary";
    size = 16;
  };
}
