{
  indicator-application-gtk3,
}:
indicator-application-gtk3.overrideAttrs (old: {
  postPatch =
    ''
      substituteInPlace data/indicator-application.desktop.in \
      --replace "OnlyShowIn=Unity;GNOME;" "OnlyShowIn=Unity;GNOME;Pantheon;"
    ''
    + (old.postPatch or "");
})
