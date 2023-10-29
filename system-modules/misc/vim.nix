{
	pkgs,
	...
}:
{
  environment.variables = { EDITOR = "vim"; };
  environment.sessionVariables = { EDITOR = "vim"; };
  environment.systemPackages = with pkgs; [
  ( neovim.override {
      vimAlias = true;
      configure = {
        customRC = ''
      	  set nocompatible
      	  set shiftwidth=4
      	  set tabstop=4
      	  set expandtab
      	  set nobackup

      	  filetype on
      	  filetype plugin on
      	  filetype indent on

      	  syntax on

      	  set number
      	  set relativenumber
      	  set cursorline

      	  set scrolloff=8
      	  set wrap
      	  set showmode

      	  set incsearch
      	  set ignorecase
      	  set smartcase
      	  set noshowmatch

      	  set backspace=indent,eol,start

          set clipboard=unnamedplus
        '';
      };
    })
  ];	
}

