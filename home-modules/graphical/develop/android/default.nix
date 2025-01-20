{ config, pkgs, ... }:
{
  # super basic (TODO: create single vim.nix config and use here and in system vim (maybe vscode vim?))
  xdg.configfile."ideavim/ideavimrc".text = ''
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
}
