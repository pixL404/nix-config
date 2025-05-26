{
  fetchurl,
  appimageTools,
}:
let
  pname = "zen";
  version = "1.12.8b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/${pname}-x86_64.AppImage";
    hash = "sha256-974n8beJnJTCgC7a/jwyA7MDuhkY2FidX0iimTqIVIg=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/${pname}.desktop --replace-fail 'Exec=zen %u' 'Exec=${pname} %u'
    '';
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/128x128/apps/${pname}.png \
    $out/share/icons/hicolor/128x128/apps/${pname}.png
  '';
}
