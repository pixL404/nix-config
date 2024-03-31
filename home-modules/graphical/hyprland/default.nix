{
  pkgs,
  inputs,
  monitors,
  keyboard,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    #disableAutoReload = false;
    extraConfig = import ./config.nix {
      colors = pkgs.hyprland-catppuccinColors; # from overlay
      monitors = monitors;
      keyboard = keyboard;
    };
    xwayland.enable = true;
  };

  # plugins
  home.packages = with inputs.hyprland-contrib.packages.${pkgs.system}; [
    grimblast
  ];
}
