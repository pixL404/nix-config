{
  config,
  pkgs,
  inputs,
  osConfig,
  ...
}:
let
  monitors = config.hardwareConf.monitors;
  keyboard = config.hardwareConf.keyboard;
in
{
  # hypr-contrib packages
  home.packages =
    (with pkgs; [
      hyprpolkitagent
      hyprland-qtutils
    ])
    ++ (with inputs.hyprland-contrib.packages.${pkgs.system}; [ grimblast ]);

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gnome
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # plugins = with inputs.hyprland-contrib.packages.${pkgs.system}; [
    # ];

    # TODO: wait for hyprscroller update to 0.47.
    # plugins = with pkgs.hyprlandPlugins; [ hyprscroller ];

    sourceFirst = true;
    settings = {

      monitor = import ./modules/monitors.nix { inherit pkgs monitors; };

      cursor.inactive_timeout = 5.0;

      exec-once = import ./modules/autostart.nix { inherit pkgs; };

      env = import ./modules/environment.nix { };

      input = import ./modules/input.nix { };

      device = import ./modules/device.nix { keyboard = keyboard; };

      general = import ./modules/general.nix { };

      decoration = import ./modules/decoration.nix { };

      animations = import ./modules/animations.nix { };

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

      windowrulev2 = import ./modules/windowrules.nix { };

      workspace = import ./modules/workspace.nix { inherit pkgs monitors; };

      "$mainMod" = "SUPER";
      bind = import ./modules/binds.nix { inherit pkgs osConfig; };

      bindm = [
        # Mov./modules/resize windows with mainMod + LM./modules/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # experimental = {
      #   xx_color_management_v4 = true;
      #   wide_color_gamut = true;
      # };

    };
    extraConfig = import ./modules/extra.nix;
  };

  # programs.hyprlock = {
  #   enable = true;
  # };

}
