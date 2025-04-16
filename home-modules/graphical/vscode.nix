{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    # prevent installing of extensions inside vscode
    mutableExtensionsDir = false;

    # disable vscode update notifications
    # enableUpdateCheck = false;

    package = pkgs.vscode;

    profiles.default = {
      # enable extension updates inside vscode
      enableExtensionUpdateCheck = true;

      extensions = with pkgs.vscode-extensions; [
        mkhl.direnv

        jnoortheen.nix-ide

        vscodevim.vim

        # theming
        catppuccin.catppuccin-vsc-icons
        pkgs.catppuccin-vsc # from overlay

        # language support

        rust-lang.rust-analyzer
        tamasfe.even-better-toml

        vadimcn.vscode-lldb

        golang.go

        james-yu.latex-workshop
        # ltex-plus.vscode-ltex-plus

        haskell.haskell
        justusadam.language-haskell

        dart-code.flutter
        dart-code.dart-code
      ];

      userSettings = {
        "telemetry.telemetryLevel" = "off";

        # workaround for wayland native electron apps
        "window.titleBarStyle" = "custom";

        "window.zoomLevel" = 1;
        "window.menuBarVisibility" = "compact";

        # === === === nix ide === === ===
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixfmt";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };

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

        # === === === language settings === === ===
        # Use the path to the root directory of ltex-ls-plus (it contains bin and lib subdirectories).
        # "ltex.ltex-ls.path" = "${pkgs.ltex-ls-plus}";
        # "ltex.java.path" = "${pkgs.jre21_minimal}";
        # "ltex.language" = "de-AT";

        # === === === filetype settings === === ===
        #nix
        "[nix]" = {
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };

        #py
        "[python]" = {
          "editor.defaultFormatter" = "ms-python.black-formatter";
        };

        # haskell
        "haskell.manageHLS" = "PATH";

        # flutter
        "dart.checkForSdkUpdates" = false;
      };
    };
  };
}
