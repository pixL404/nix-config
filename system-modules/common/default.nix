{ 
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./packages.nix
  ];

  # allow unfree packages
  # pkgs.config.allowUnfree = true;
  
  # enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      # prevent boot menu flooding
      configurationLimit = 10;
    };
  };

  # Set time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "all"
    ];
    extraLocaleSettings = {
      LC_TIME = "de_AT.UTF-8";
    };
  };

  # enable cloudflare dns
  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111" 
    "2606:4700:4700::1001"
  ];

  # enable fish shell
  programs.fish = {
    enable = true;
  };

  # enhance fish completion
  documentation.man.generateCaches = true;
  environment.pathsToLink = [ "/share/fish" ];

  # which NixOS release to follow for options
  # research release changes before changing this value
  system.stateVersion = "unstable";


}