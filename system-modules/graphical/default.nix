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
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "caps:escape";

    # Enable touchpad support
    libinput.enable = true;
  };

  # set default window mode to wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # enable hyprland window manager
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  # set display manager
  services.xserver.displayManager = {
    defaultSession = "hyprland";
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = false;
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

}
