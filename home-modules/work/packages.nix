{ pkgs, ... }:
{
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
}
