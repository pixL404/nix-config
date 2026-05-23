{
  config,
  lib,
  options,
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
  config = lib.mkMerge [
    {
      programs.nixvim = nixvimCfg;
    }

    # => on NixOS
    (lib.optionalAttrs (options ? environment.variables) {
      environment.variables = editor;
      environment.sessionVariables = editor;
    })

    # => on Home-Manager
    (lib.optionalAttrs (options ? home.sessionVariables) {
      hm.home.sessionVariables = editor;
    })
  ];
}
