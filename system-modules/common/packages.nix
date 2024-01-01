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

    lm_sensors

    gnome.geary

    gimp
  ];
}