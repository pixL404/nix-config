(import ./catppuccin.nix)
++
[
  # openrgb
  (my: pkgs: {
    openrgb = pkgs.openrgb.overrideAttrs (old: {
      version = "git";
      src = pkgs.fetchFromGitLab {
        owner = "CalcProgrammer1";
        repo = "OpenRGB";
        rev = "1a68abc8a074a90f03ef6f164eca37fbdd4cb95b";
        hash = "sha256-8QXkTxc97JUIdfuBsNb7jRTeidMAeT4znj+FYlOOkYo=";
      };
    });
  })

  # waybar
  (my: pkgs: {
    waybar = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
      patches = (oa.patches or []) ++ [
        (pkgs.fetchpatch {
          name = "fix waybar wlr/workspace clicking";
          url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
          sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
        })
      ];
    });
  })

  # minecraft server files
  (my: pkgs: {
    minecraft-server-1-20-1 = pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: {
      version = "1.20.1";
      src = pkgs.fetchurl {
        url = "https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar";
        sha1 = "84194a2f286ef7c14ed7ce0090dba59902951553";
      };
    });
    fabric-server-1-20-1 = pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: {
      version = "fabric-1.20.1";
      src = pkgs.fetchurl {
        url = "https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.11/1.0.1/server/jar";
        hash = "sha256-/j9wIzYSoP+ZEfeRJSsRwWhhTNkTMr+vN40UX9s+ViM=";
      };
    });
    minecraft-server-1-21 = pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: {
      version = "1.20.1";
      src = pkgs.fetchurl {
        url = "https://piston-data.mojang.com/v1/objects/59353fb40c36d304f2035d51e7d6e6baa98dc05c/server.jar";
        sha1 = "59353fb40c36d304f2035d51e7d6e6baa98dc05c";
      };
    });
  })

  (my: pkgs: {
    vesktop = pkgs.vesktop.override {
      vencord = pkgs.vencord;
      withSystemVencord = true;
    };
  })

  # pantheon patches and applications for tray icons
  (my: pkgs: {
    wingpanel-community-indicators = pkgs.wingpanel-indicator-ayatana.overrideAttrs (old: {
      pname = "wingpanel-community-indicators";
      version = "2.0.0";

      src = pkgs.fetchFromGitHub {
        owner = "MvBonin";
        repo = "wingpanel-community-indicators";
        rev = "master";
        sha256 = "sha256-dOAbH1YWrK6rG7C9vv4ySwxZ3e2pLprQ2n4MZMlU1yo=";
      };

      nativeBuildInputs = with pkgs; [
        json-glib
      ]
      ++ old.nativeBuildInputs;
    });

    indicator-application-gtk3 = pkgs.indicator-application-gtk3.overrideAttrs (old: {
      postPatch = ''
        substituteInPlace data/indicator-application.desktop.in \
        --replace "OnlyShowIn=Unity;GNOME;" "OnlyShowIn=Unity;GNOME;Pantheon;"
      ''
      + (old.postPatch or "");
    });

    # TODO: fix not compiling; it needs dependency "switchboard-2.0"
    # workaround is to edit the files in ~/.config/indicators
    switchboard-plug-indicators = pkgs.stdenv.mkDerivation rec {
      pname = "switchboard-plug-indicators";
      version = "0.1";

      src = pkgs.fetchFromGitHub {
        owner = "MvBonin";
        repo = pname;
        rev = "master";
        sha256 = "sha256-KQ9hFQVopCF5NZXEgUXNw7aS+Z6SqzMCwyxJUjiZMnA=";
      };

        nativeBuildInputs = with pkgs; [
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

        buildInputs = with pkgs; [
          pantheon.granite
          gtk3
          libgee
          libhandy
        ];

        passthru = {
          updateScript = pkgs.nix-update-script { };
        };
    };
  })

  # (my: pkgs: {
  #   palmreject = pkgs.stenv.mkDerivation {
  #     pname = "palmreject";
  #     name = "palmreject";

  #     src = pkgs.fetchFromGitHub {
  #       owner = "olofmogren";
  #       repo = "palmreject";
  #       rev = "master";
  #       # hash = "sha256-TdHUJ7ufP3fgV+OrMu+m0hdpG3zwnBIZKJFaHhlO+1M=";
  #     };

  #     nativeBuildInputs = with pkgs; [
  #       bash
  #       xorg.xinput
  #     ];



  #   }
  # })

  # (my: pkgs: {
  #   hyprscroller = pkgs.stdenv.mkDerivation {
  #     pname = "hyprscroller";
  #     name = "hyprscroller";

  #     # CXX = "${pkgs.cmake}/bin/cmake";

  #     nativeBuildInputs = with pkgs; [
  #       cmake
  #       pkg-config
  #       makeWrapper
  #     ];

  #     buildInputs = with pkgs; [
  #       hyprland #TODO: use hyprland from flake inputs

  #       wayland
  #       wlroots

  #       libxkbcommon
  #       libGL
  #       libinput
  #       libdrm
  #       pixman
  #     ];

  #     C_INCLUDE_PATH = "${pkgs.hyprland}/include";

  #     buildPhase = ''
  #       make all
  #     '';

  #     src = pkgs.fetchFromGitHub {
  #       owner = "dawsers";
  #       repo = "hyprscroller";
  #       rev = "master";
  #       hash = "sha256-eKmnhvdDUXNU1dUE67L3F/Gcne4QIoRkTKJ+H0Eiqkg=";
  #     };
  #   };
  # })

  # (my: pkgs: {
  #   myxer = pkgs.rustPlatform.buildRustPackage rec {
  #     pname = "myxer";
  #     version = "1.2.1";

  #     src = pkgs.fetchFromGitHub {
  #       owner = "VixenUtils";
  #       repo = "Myxer";
  #       rev = version;
  #       hash = "sha256-PT57BLNQhj9v/auoyDgGF4gqDQ7jriPB1sp70uu/0C4=";
  #     };

  #     # cargoHash = pkgs.lib.fakeHash;
  #     cargoLock.lockFile = "${src}/Cargo.lock";
      
  #     buildInputs = with pkgs; [
  #       gtk3
  #       libpulseaudio
  #     ];


  #     meta = with pkgs.lib; {
  #       description = "A modern Volume Mixer for PulseAudio, built with you in mind.";
  #       homepage = "https://github.com/VixenUtils/Myxer/tree/master";
  #       license = licenses.gpl3;
  #       maintainers = [ "me" ];
  #       mainProgram = "myxer";
  #     };
  #   };
  # })
]