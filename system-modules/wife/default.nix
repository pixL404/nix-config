{
  config,
  pkgs,
  ...
}:
{
  services.xserver.desktopManager.gnome.enable = false;
  # move to pantheon
  services.xserver.desktopManager.pantheon.enable = true;
  # programs.pantheon-tweaks.enable = true;
  environment.systemPackages = with pkgs; [
    pantheon-tweaks
  ];

  services.pantheon.apps.enable = true;

  users.users.emmi = {
    isNormalUser = true;
    packages = with pkgs; [
      krita
    ];
  };
}