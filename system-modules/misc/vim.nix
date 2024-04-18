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
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "frappe";
    };

    opts = {
      number = true;
      relativenumber = true;
      cursorline = true;

      # filetype = {
      #   enable = true;
      #   plugin = true;
      #   indent = true;
      # };

      # ?
      # filetype = true;
      # filetype-indent-on = true;
      # filetype-plugin-on = true;
      # syntax = true;

      scrolloff = 8;
      wrap = true;
      showmode = true;

      incsearch = true;
      ignorecase = true;
      smartcase = true;
      showmatch = false;

      backspace = "indent,eol,start";

      clipboard = "unnamedplus";

      # syntax = true;

      # scrolloff = 8;
      # wrap = true;
      # showmode = true;

      # incsearch = true;


    };
  };

  # environment.systemPackages = with pkgs; [
#   ( neovim.override {
#       vimAlias = true;
#       configure = {
#         customRC = ''
#       	  set nocompatible
#       	  set shiftwidth=4
#       	  set tabstop=4
#       	  set expandtab
#       	  set nobackup
# 
#       	  filetype on
#       	  filetype plugin on
#       	  filetype indent on
# 
#       	  syntax on
# 

# 
#       	  set backspace=indent,eol,start
# 
#           set clipboard=unnamedplus
#         '';
#       };
#     })
  # ];	
}

