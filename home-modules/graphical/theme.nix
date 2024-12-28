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

    #programs
    waybar.enable = true;
    gtk.enable = false; # currently broken?
    kvantum.enable = true;
    hyprland.enable = true;
    foot.enable = true;
    dunst.enable = true;
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
    size = 16;
  };
}
