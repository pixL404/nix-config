{ ... }:
{
  custom = {
    enableGraphical = false;
    gaming.enable = false;
    enableHome = false;
    isWorkMachine = false;
    isServer = true;

    hardware.enable = true;
  };

  imports = [
    ./hardware.nix

    # TODO: find fitting modules in nixos-hardware?
  ];

  networking.hostName = "viltrum";
}
