{
  lib,
  ...
}:
{
  options.homelab = {
    baseDomain = lib.mkOption {
      description = "base domain of caddy";
      type = lib.types.str;
      default = "";
    };
  };
}
