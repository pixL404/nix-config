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
        url = "https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.6/1.0.0/server/jar";
        hash = "sha256-vOULXIe2hz5p49rdlXINsHYsl5whx6PQE0HnLxd6Vl0=";
      };
    });
  })

  (my: pkgs: {
    vesktop = pkgs.vesktop.override {
      vencord = pkgs.vencord;
      withSystemVencord = true;
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