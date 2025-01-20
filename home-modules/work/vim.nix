{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../../shared-modules/vim-config
  ];

  programs.nixvim = {
    defaultEditor = true;
    vimdiffAlias = true;

    extraConfigVim = ''
      		let g:clipboard = {
      			\   'name': 'win32yank-wsl',
      			\   'copy': {
      			\      '+': 'win32yank.exe -i --crlf',
      			\      '*': 'win32yank.exe -i --crlf',
      			\    },
      			\   'paste': {
      			\      '+': 'win32yank.exe -o --lf',
      			\      '*': 'win32yank.exe -o --lf',
      			\   },
      			\   'cache_enabled': 0,
      			\ }
      		'';
  };
}
