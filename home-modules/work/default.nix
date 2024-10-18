{
  config,
  pkgs,
  home-manager,
  ...
}:
{
	imports = [
		./packages.nix
		./vim.nix
	];
}