{
  config,
  pkgs,
  home-manager,
	lib ? pkgs.lib,
  ...
}:
{
  imports = [
    ./packages.nix
    ./vim.nix
  ];
}
