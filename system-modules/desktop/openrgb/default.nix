{
  config,
  pkgs,
  ...
}:
{
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  services.udev.extraRules = import ./rules.nix {};

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];
}