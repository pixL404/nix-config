{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./minecraft.nix
    ./steam.nix
  ];
}