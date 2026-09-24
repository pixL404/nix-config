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

  homelab = {
    baseDomain = "pixl404.duckdns.org";
    services = {
      vault.enable = true;

      jellyfin.enable = true;

      arrUsers.enable = true;
      bazarr.enable = true;
      prowlarr.enable = true;
      recyclarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;
      seerr.enable = true;
      torrent.enable = true;
      flaresolverr.enable = true;

      pihole.enable = true;
    };
  };

  services.openssh.enable = true;
  imports = [
    ./hardware.nix

    # TODO: find fitting modules in nixos-hardware?
  ];

  networking.hostName = "viltrum";
}
