{
  config,
  inputs,
  lib,
  ...
}:
let
  isWorkMachine = config.custom.isWorkMachine;
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
  #imports = lib.mkMerge [ [] (lib.mkIf (!isWorkMachine) [ inputs.nixvim.nixosModules.nixvim ]) ];
  imports = lib.mkIf (!isWorkMachine) [ inputs.nixvim.nixosModules.nixvim ];

  # hm.imports =lib.mkMerge [ [] (lib.mkIf (isWorkMachine) [ inputs.nixvim.homeModules.nixvim ]) ];
  hm.imports =lib.mkIf (isWorkMachine) [ inputs.nixvim.homeModules.nixvim ];

  environment.variables = editor;
  environment.sessionVariables = editor;
  # home-manager.home.sessionVariables = editor;

  programs.nixvim = lib.mkIf (!isWorkMachine) nixvimCfg;
  hm.programs.nixvim = lib.mkIf (isWorkMachine) nixvimCfg;
}
