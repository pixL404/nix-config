{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.hardware;
in
{
  config = lib.mkIf cfg.enable {
    # enable nix flakes
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # allow remote rebuilding
      trusted-users = [ "@wheel" ];
    };

    # Use the systemd-boot EFI boot loader.
    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "boot.shell_on_fail"
      ];
      plymouth.enable = true;

      loader = {
        # hold space to see generations
        timeout = 0;
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          editor = false;
          # prevent boot menu flooding
          configurationLimit = 10;
        };
      };
    };

    # Set time zone.
    time.timeZone = "Europe/Vienna";

    # Select internationalisation properties.
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [ "all" ];
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

    #enable firmware update via fwupd
    services.fwupd.enable = true;

    # which NixOS release to follow for options
    # research release changes before changing this value
    system.stateVersion = "25.05";
  };
}
