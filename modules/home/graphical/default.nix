{
  config,
  lib,
  ...
}:
{
  hm.config = lib.mkIf config.custom.enableGraphical {

    services.mpris-proxy.enable = true;

    # open source rich presence server
    services.arrpc.enable = true;

    # audio mixer for pipewire
    services.easyeffects.enable = true;

    # notification service
    services.dunst.enable = false;
  };
}
