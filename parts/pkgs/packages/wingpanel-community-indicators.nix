{
  wingpanel-indicator-ayatana,
  fetchFromGitHub,
  json-glib,
}:
# pantheon patches and applications for tray icons
wingpanel-indicator-ayatana.overrideAttrs (old: {
  pname = "wingpanel-community-indicators";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "MvBonin";
    repo = "wingpanel-community-indicators";
    rev = "master";
    sha256 = "sha256-dOAbH1YWrK6rG7C9vv4ySwxZ3e2pLprQ2n4MZMlU1yo=";
  };

  nativeBuildInputs = [ json-glib ] ++ old.nativeBuildInputs;
})
