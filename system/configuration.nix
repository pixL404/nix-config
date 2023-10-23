{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # include home-manager file (which imports home configuration)
      ./home-manager.nix

      ./vim.nix
      ./fonts.nix
      ./bluetooth.nix
    ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # additional kernel modules
  boot.kernelModules = [ "coretemp" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "caps:escape";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  # enable fish shell
  programs.fish = {
    enable = true;
  };

  # enhance fish completion
  documentation.man.generateCaches = true;
  environment.pathsToLink = [ "/share/fish" ];

  # set default window mode to wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # enable hyprland window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # set display manager
  services.xserver.videoDrivers = [ "intel" "nouveau" ];
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];
    shell = pkgs.fish;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    service-wrapper
  
    lxqt.lxqt-policykit
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    waybar
    waypaper
    swww
    swaybg
    wofi
    dunst
  
    cliphist
    wl-clipboard
    wl-clip-persist

    lm_sensors
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  networking.wireless = {
    enable = true;
    environmentFile = "/var/lib/misc/wireless_secrets.env";
    networks = {
      Genkidama_5G = {
        psk = "@HOME_WIFI_PSK@";
      };
    };
  };

}

