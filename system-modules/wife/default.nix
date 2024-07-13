{
  config,
  pkgs,
  ...
}:
{
  users.users.emmi = {
    isNormalUser = true;
    packages = with pkgs; [
      krita
    ];
  };
}