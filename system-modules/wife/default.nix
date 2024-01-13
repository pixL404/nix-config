{
  config,
  pkgs,
  ...
}:
{
  services.xserver.desktopManager.gnome.enable = false;
  # move to pantheon
  services.xserver.desktopManager.pantheon.enable = true;
  programs.pantheon-tweaks.enable = true;
  services.pantheon.apps.enable = true;

  users.users.emmi = {
    isNormalUser = true;
  };
}