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

    gnome.geary
    gnome.nautilus
    gnome.eog
    gnome.file-roller

    gimp
  ];
}