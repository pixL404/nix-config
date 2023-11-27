{
  config,
  pkgs,
  ...
}:
{
  # enable wifi
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
    #appendNameServers = [];
  };
  # enable intel video drivers
  services.xserver.videoDrivers = [ "intel" "nouveau" ];
}