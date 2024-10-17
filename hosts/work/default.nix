{
  config,
  pkgs,
  home-manager,
  inputs,
  ...
}:
{
  imports = [
    ../../home-modules/common
  ];

	# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}