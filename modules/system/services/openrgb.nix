{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.hardware.openrgb;
in
{
  config = lib.mkIf cfg.enable {

    boot.kernelModules = [
      "i2c-dev"
      "i2c-piix4"
    ];
    hardware.i2c.enable = true;
    services.udev.packages = [ pkgs.openrgb ];
    services.hardware.openrgb = {
      # enable = true;
      package = pkgs.openrgb;
      motherboard = "amd";
    };

    environment.systemPackages = with pkgs; [ i2c-tools ];
  };
}
