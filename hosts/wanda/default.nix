{
  inputs,
  ...
}:
{
  imports = [
    # hardware scan
    ./hardware.nix
    # ./home.nix

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  custom = {
    enableGraphical = true;
    enableHome = true;
    isWorkMachine = false;

    hardware.enable = true;
    gaming = {
      enable = true;
      hostMineCraftServer = true;
    };

    AI.enable = false; # TODO: figure out how to do this via nixos container or specialisation?
  };

  services = {
    evremap.enable = true;
    openssh.enable = true;
    hardware.openrgb.enable = true;
  };

  networking.hostName = "wanda";

  # enable nixos-containers (e.g. minecraft server)
  boot.enableContainers = true;

  graphical = {
    develop.enable = true;
    obs.enable = true;

    hyprland = {
      enable = true;
      enableLock = false;
      monitors = {
        primary = {
          name = "DP-2";
          resolution = "2560x1440";
          refresh_rate = 180;
          position = "1080x420"; # correct position to be next to vertical monitor
          scaling = 1.0;
          misc = [
            "bitdepth, 10"
            "vrr, 2" # vrr 2 => fullscreen only
          ];
        };
        other = [
          {
            name = "HDMI-A-2";
            resolution = "1920x1080";
            refresh_rate = 76;
            position = "0x0";
            scaling = 1.0;
            misc = [
              "transform, 1" # 90 degree rotate
            ];
            orientation = "top"; # top to bottom master layout
          }
        ];
      };
      keyboard = "chicony-perixx-ergo-keyboard";
    };
  };
}
