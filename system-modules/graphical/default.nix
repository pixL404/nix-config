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
  
  # allow hyprland flake derivations be downloaded from cachix, instead of building 
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # tty settings
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      options = "caps:escape";
    };

    # Enable touchpad support
    libinput.enable = true;
  };

  # set default window mode to wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # set display manager
  services.displayManager= {
    # TODO: does lightdm work under wayland?
    # session = [{
    #   manage = "desktop";
    #   name = "myHyprland";
    #   start = ''exec Hyprland'';
    # }];
    # lightdm = {
    #   enable = true;
    #   greeters.pantheon.enable = true;
    # };

    # gdm = {
    #   enable = true;
    #   wayland = true;
    #   autoSuspend = false;
    # };

    sddm = {
      enable = true;
      wayland.enable = false;
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
    # defaultSession = "pantheon";
  
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
