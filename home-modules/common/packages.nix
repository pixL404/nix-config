
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
		fortune
	];
}