{
  config,
  pkgs,
  lib,
  ...
}:
{
  hm.config = lib.mkIf config.custom.isWorkMachine {
    home.packages = with pkgs; [
      # ansible needs pykerberos python module
      (
        (ansible.overrideAttrs (
          new: old: {
            propagatedBuildInputs = [ pkgs.python312Packages.pykerberos ] ++ old.propagatedBuildInputs;
          }
        )).override
        { windowsSupport = true; }
      )

      sshpass
      krb5

      inetutils
      dnsutils
    ];

    programs.nixvim = {
      defaultEditor = true;
      vimdiffAlias = true;

      extraConfigVim = ''
        let g:clipboard = {
          \   'name': 'win32yank-wsl',
          \   'copy': {
          \      '+': 'win32yank.exe -i --crlf',
          \      '*': 'win32yank.exe -i --crlf',
          \    },
          \   'paste': {
          \      '+': 'win32yank.exe -o --lf',
          \      '*': 'win32yank.exe -o --lf',
          \   },
          \   'cache_enabled': 0,
          \ }
      '';
    };
  };
}
