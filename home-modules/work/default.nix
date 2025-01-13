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

	# let me configure by hand because of corporate email :)
  programs.git.enable = lib.mkForce false; 
}