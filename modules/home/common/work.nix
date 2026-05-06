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
            propagatedBuildInputs = with pkgs.python312Packages; [ pykerberos cryptography pyopenssl ] ++ old.propagatedBuildInputs;
          }
        )).override
        { windowsSupport = true; }
      )

      sshpass
      krb5

      inetutils
      dnsutils
      python312Full
      openldap

      sops
      age
      talosctl
      kubectl
    ];

    programs.git.enable = lib.mkForce false;

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
