{
  config,
  pkgs,
  ...
}:
{
  services.xserver.desktopManager.gnome.enable = true;

  users.users.emmi = {
    isNormalUser = true;
  };
}