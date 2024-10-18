{
	pkgs,
  inputs,
	...
}:
{
  environment.variables = { EDITOR = "nvim"; };
  environment.sessionVariables = { EDITOR = "nvim"; };

  imports = [
    inputs.nixvim.nixosModules.nixvim
    ../../shared-modules/vim-config
  ];
}

