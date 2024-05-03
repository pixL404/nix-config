# settings for machines where user input is expected (dekstop, laptop)
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./packages.nix
    ./fonts.nix
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
    envVars.enable = false;
  };

  # set display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin";
    settings = {
      Users = {
        RememberLastUser = true;
        RememberLastSession = true;
      };
    };
    extraPackages = with pkgs.libsForQt5; [
      qt5.qtgraphicaleffects
    ];
  };

  # automatically unlock gnome keyring upon login
  security.pam.services.sddm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  # add gui for keyring
  programs.seahorse.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  
  # enable support for logitech mice (solaar daemon)
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # enable dconf (settings for gnome apps)
  programs.dconf.enable = true;
}
