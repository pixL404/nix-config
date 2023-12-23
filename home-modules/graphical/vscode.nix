{
  pkgs,
  ...
}:
{
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
      catppuccin.catppuccin-vsc-icons
     (pkgs.catppuccin-vsc.override {
       accent = "lavender";
       boldKeywords = true;
       italicComments = true;
       italicKeywords = true;
       extraBordersEnabled = false;
       workbenchMode = "default";
       bracketMode = "rainbow";
       colorOverrides = {};
       customUIColors = {};
     })
    ];

    userSettings = {
      "telemetry.telemetryLevel" = "off";

      # workaround for wayland native electron apps
      "window.titleBarStyle" = "custom";

      "window.zoomLevel" = 1;
      "window.menuBarVisibility" = "compact";

      # === === === theming === === ===

      "catppuccin.accentColor" = "lavender";
      "workbench.colorTheme" = "Catppuccin Frappé";
      "workbench.iconTheme" = "catppuccin-frappe";
      # we try to make semantic highlighting look good
      "editor.semanticHighlighting.enabled" = true;
      # prevent VSCode from modifying the terminal colors
      "terminal.integrated.minimumContrastRatio" = 1;
      
      "files.autoSave" = "onFocusChange";

      "editor.fontFamily" = "'FontAwesome', 'JetBrains Mono','monospace', monospace";
      "editor.fontLigatures" = true;

      # vscodevim
      "vim.highlightedyank.enable" = true;
      "vim.useSystemClipboard" = true;
      "vim.visualstar" = true;
      "editor.lineNumbers" = "relative";
      "vim.smartRelativeLine" = true;
      "editor.cursorSurroundingLines" = 10;
      # enable remapping of caps to esc
      "keyboard.dispatch" = "keyCode";
      
      # git
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;

      "editor.minimap.size" = "fit";
      "editor.minimap.autohide" = true;

      # unnecessary confirm dialogs
      "explorer.confirmDragAndDrop" = false;
      "workbench.startupEditor" = "none";

      # === === === filetype settings === === ===
      #nix
      "[nix]" = {
        "editor.tabSize" = 2;
      };
    };
  };
}
