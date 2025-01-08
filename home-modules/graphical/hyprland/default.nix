{
  pkgs,
  inputs,
  monitors,
  keyboard,
  ...
}:
{
  # hypr-contrib packages
  home.packages = (with pkgs; [
    hyprpolkitagent
    hyprland-qtutils
  ])
  ++ (with inputs.hyprland-contrib.packages.${pkgs.system}; [
    grimblast
  ]);

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # plugins = with inputs.hyprland-contrib.packages.${pkgs.system}; [
    # ];

    plugins = with pkgs.hyprlandPlugins; [
      hyprscroller
    ];


    sourceFirst = true;
    settings = {
      
      monitor = import ./modules/monitors.nix { inherit pkgs monitors ; };

      cursor.inactive_timeout = 5.0;

      exec-once = import ./modules/autostart.nix {};

      env = import ./modules/environment.nix {};

      input = import ./modules/input.nix {};

      device = import ./modules/device.nix {
        keyboard = keyboard;
      };

      general = import ./modules/general.nix {};

      decoration = import ./modules/decoration.nix {};

      animations = import ./modules/animations.nix {};

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
      };

      gestures = {
        workspace_swipe = true;
      };

      windowrulev2 = import ./modules/windowrules.nix {};

      workspace = import ./modules/workspace.nix { inherit pkgs monitors ; };

      "$mainMod" = "SUPER";
      bind = import ./modules/binds.nix {};

      bindm = [
        # Mov./modules/resize windows with mainMod + LM./modules/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

    };
    extraConfig = import ./modules/extra.nix;
  };

  # programs.hyprlock = {
  #   enable = true;
  # };

}
