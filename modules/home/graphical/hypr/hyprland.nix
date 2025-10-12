{
  config,
  pkgs,
  inputs', # inputs with the correct system already applied
  lib,
  ...
}:
let
  cfg = config.graphical.hyprland;
in
{
  hm.config = lib.mkIf cfg.enable {
    # necessary packages for me
    home.packages = [
      pkgs.hyprpolkitagent
      pkgs.hyprland-qtutils
      pkgs.hyprcursor
      inputs'.hyprland-contrib.packages.grimblast
    ];

    # weird xdg portal stuff
    # https://wiki.archlinux.org/title/XDG_Desktop_Portal

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      # plugins = with pkgs.hyprlandPlugins; [ hyprscroller ];

      sourceFirst = true;
      settings = {

        monitor = import ./modules/monitors.nix { inherit lib config; };

        cursor.inactive_timeout = 5.0;

        exec-once = import ./modules/autostart.nix { inherit pkgs; };

        env = import ./modules/environment.nix { };

        input = import ./modules/input.nix { };

        device = import ./modules/device.nix { keyboard = cfg.keyboard; };

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

        # TODO: configure new gesture stuff
        # gestures = {
        #   workspace_swipe = true;
        # };

        windowrulev2 = import ./modules/windowrules.nix { };

        workspace = import ./modules/workspace.nix {
          inherit lib;
          monitors = cfg.monitors;
        };

        "$mainMod" = "SUPER";
        bind = import ./modules/binds.nix { inherit config pkgs lib; };

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
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

    programs.hyprlock = {
      enable = cfg.enableLock;
      # TODO custom lockscreen settings
    };
  };
}
