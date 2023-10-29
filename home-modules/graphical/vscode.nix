{
  pkgs,
  ...
}:
{
# TODO: update this to inputs overlays when moved to flakes
#  import pkgs.path { overlays = [
#      (self: super: {
#        myTheme = super.pkgs.vscode-extensions.catppuccin.catppuccin-vsc.override {
#          accentColor = "lavendar";
#          boldKeywords = true;
#          italicComments = true;
#          extraBordersEnabled = false;
#          workbenchMode = "default";
#          bracketMode = "rainbow";
#        };
#      })
#   ]};
  programs.vscode = {
    enable = true;

    # enable extension updates inside vscode
    enableExtensionUpdateCheck = true;
    # allow installing of extensions inside vscode
    mutableExtensionsDir = true;

    # disable vscode update notifications
    # enableUpdateCheck = false;

    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix

      vscodevim.vim
  
      # theming
      # TODO: add when moving to flakes
      #catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
    ];

    #userSettings = {
    #  "window.titleBarStyle" = "custom";
    #};

#    userSettings = {
#      // we try to make semantic highlighting look good
#      "editor.semanticHighlighting.enabled": true,
#      // prevent VSCode from modifying the terminal colors
#      "terminal.integrated.minimumContrastRatio": 1,
#      // make the window's titlebar use the workbench colors
#      "window.titleBarStyle": "custom",
#    };

  };
}
