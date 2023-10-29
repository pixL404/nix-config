{
  config,
  pkgs,
  ...
}:
{
  # enable wifi
  networking.wireless = {
    enable = true;
    environmentFile = "/var/lib/misc/wireless_secrets.env";
    networks = {
      Genkidama_5G = {
        psk = "@HOME_WIFI_PSK@";
      };
    };
  };

  # enable intel video drivers
  services.xserver.videoDrivers = [ "intel" "nouveau" ];
}