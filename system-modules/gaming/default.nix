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

  # programs/launcher without special needs
  environment.systemPackages = with pkgs; [
    ryujinx
    heroic
  ];
}