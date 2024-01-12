{
  config,
  pkgs,
  ...
}:
{
  programs.adb.enable = true;
  users.users.alex.extraGroups = ["adbusers"];

  environment.systemPackages = with pkgs; [
    android-studio
    kotlin
    jdk
    android-tools
  ];
}
