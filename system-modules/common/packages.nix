{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wget
    git
    service-wrapper

    lm_sensors

    gnome.geary

    gimp
  ];
}