{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.custom.hardware.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services.blueman.enable = true;
  };
}
