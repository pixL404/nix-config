{
  lib,
  stdenv,
  fetchFromGitHub,

  meson,
  ninja,
  pkg-config,
  python3,
  vala,
  wrapGAppsHook3,
  pantheon,
  json-glib,
  appstream,

  gtk3,
  libgee,
  libhandy,

  nix-update-script,
}:
# TODO: fix not compiling; it needs dependency "switchboard-2.0"
# workaround is to edit the files in ~/.config/indicators
stdenv.mkDerivation rec {
  pname = "switchboard-plug-indicators";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "MvBonin";
    repo = pname;
    rev = "master";
    sha256 = "sha256-KQ9hFQVopCF5NZXEgUXNw7aS+Z6SqzMCwyxJUjiZMnA=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
    vala
    wrapGAppsHook3
    pantheon.switchboard
    json-glib
    appstream
  ];

  buildInputs = [
    pantheon.granite
    gtk3
    libgee
    libhandy
  ];

  passthru = {
    updateScript = nix-update-script { };
  };
}
