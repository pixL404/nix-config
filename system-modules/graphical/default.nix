# settings for machines where user input is expected (dekstop, laptop)
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./packages.nix
    ./fonts.nix
    ./sound.nix

    # catppuccin module
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # tty settings
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      options = "caps:escape";
    };
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # set default window mode to wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # use downstream nixos and home-manager modules instead of hyprland flake
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    # https://github.com/NixOS/nixpkgs/issues/308287#issuecomment-2093091892
    # envVars.enable = false;
  };

  # set display manager
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.pantheon.enable = true;
  };

  # move to pantheon
  services.xserver.desktopManager.pantheon = {
    enable = true;

    extraWingpanelIndicators = with pkgs; [
      wingpanel-community-indicators # from overlay
    ];

    extraSwitchboardPlugs = with pkgs; [
      switchboard-plug-indicators # from overlay
    ];
  };

  services.pantheon.apps.enable = true;

  # automatically unlock gnome keyring upon login
  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  # add gui for keyring
  programs.seahorse.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # enable support for logitech mice (solaar daemon)
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # enable dconf (settings for gnome apps)
  programs.dconf.enable = true;
}
