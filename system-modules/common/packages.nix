{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wget
    git
    service-wrapper
    htop
    inetutils
    usbutils
    pciutils
    libinput

    lm_sensors

    # gnome packages
    geary
    nautilus
    eog
    file-roller

    gimp
  ];
}