(import ./catppuccin.nix)
++ [
  # https://github.com/NixOS/nixpkgs/pull/349783
  # https://github.com/nix-community/home-manager/issues/5991
  (my: pkgs: { utillinux = pkgs.util-linux; })

  # waybar
  (my: pkgs: {
    waybar = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
      patches = (oa.patches or [ ]) ++ [
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
      electron = pkgs.electron;
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

      nativeBuildInputs = with pkgs; [ json-glib ] ++ old.nativeBuildInputs;
    });

    indicator-application-gtk3 = pkgs.indicator-application-gtk3.overrideAttrs (old: {
      postPatch =
        ''
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

  (my: pkgs: {
    zen = let 
      pname = "zen";
      version = "1.7.6b";

      src = pkgs.fetchurl {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/${pname}-x86_64.AppImage";
        hash = "sha256-GJuxooMV6h3xoYB9hA9CaF4g7JUIJ2ck5/hiQp89Y5o=";
      };
      
      appimageContents = pkgs.appimageTools.extract {
        inherit pname version src;
        postExtract = ''
          substituteInPlace $out/${pname}.desktop --replace-fail 'Exec=zen %u' 'Exec=${pname} %u'
        '';
      };
    in 
    pkgs.appimageTools.wrapType2 {
      inherit pname version src;

      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
        install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/128x128/apps/${pname}.png \
        $out/share/icons/hicolor/128x128/apps/${pname}.png
      '';
    };
    
    
  })
]
