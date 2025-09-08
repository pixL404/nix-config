{
  # config,
  inputs,
  ...
}:
let
  nixvimCfg = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
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

      clipboard = "unnamed,unnamedplus";

      # syntax = true;

      # scrolloff = 8;
      # wrap = true;
      # showmode = true;

      # incsearch = true;

    };
  };
  editor = {
    EDITOR = "nvim";
  };
in
{
  imports = [ inputs.nixvim.nixosModules.nixvim ];
  hm.imports = [ inputs.nixvim.homeModules.nixvim ];

  environment.variables = editor;
  environment.sessionVariables = editor;
  # home-manager.home.sessionVariables = editor;

  programs.nixvim = nixvimCfg;
  hm.programs.nixvim = nixvimCfg;
}
