{ config, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # not necessary, pantheon has own bluetooth service
  services.blueman.enable = true;
}
