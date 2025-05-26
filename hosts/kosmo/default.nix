{ ... }:
{
  custom = {
    enableGraphical = true;
    gaming.enable = false;
    enableHome = true;
    isWorkMachine = false;

    hardware.enable = true;
  };
  services = {
    evremap.enable = true;
  };

  imports = [
    ./hardware.nix
    # ./home.nix

    # TODO: find fitting modules in nixos-hardware?
  ];

  networking.hostName = "kosmo";

  security.pam.services.hyprlock = { };
  graphical = {
    develop.enable = true;
    hyprland = {
      enable = true;
      enableLock = false;
      monitors = {
        primary = {
          name = "eDP-1";
          resolution = "1920x1080";
          refresh_rate = 60;
          position = "auto";
          scaling = 1.0;
        };
        other = [ ];
      };
      keyboard = "at-translated-set-2-keyboard";
    };
  };
}
