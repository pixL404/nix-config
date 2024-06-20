{
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;

    # enable extension updates inside vscode
    enableExtensionUpdateCheck = true;
    # prevent installing of extensions inside vscode
    mutableExtensionsDir = false;

    # disable vscode update notifications
    # enableUpdateCheck = false;

    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      mkhl.direnv
      bbenoist.nix

      vscodevim.vim
  
      # theming
      # catppuccin.catppuccin-vsc-icons
      # pkgs.catppuccin-vsc # from overlay

      # language support

      rust-lang.rust-analyzer
      tamasfe.even-better-toml

      golang.go

      # ms-dotnettools.csharp
      # ms-dotnettools.csdevkit

      james-yu.latex-workshop

      ms-python.python
      ms-python.vscode-pylance
      ms-python.black-formatter
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
      
      #py
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
    };
  };
}
