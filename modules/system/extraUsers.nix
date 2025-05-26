{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.custom.enableGraphical {
    users.users.emmi = {
      isNormalUser = true;
      packages = with pkgs; [ krita ];
    };
  };
}
