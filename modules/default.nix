{
  lib,
  ...
}:
{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "alex" ])

    ./options/hypr.nix
    ./options/toggles.nix

    ./home # default.nix
    ./home/common # default.nix
    ./home/common/fish.nix
    ./home/common/work.nix
    ./home/graphical # default.nix
    ./home/graphical/develop/vscode.nix
    ./home/graphical/foot.nix
    ./home/graphical/hypr/hyprland.nix
    ./home/graphical/hypr/hyprpanel.nix
    ./home/graphical/mangohud.nix
    ./home/graphical/obs.nix
    ./home/graphical/packages.nix
    ./home/graphical/theme.nix

    ./shared/nixpkgs.nix
    ./shared/nixvim.nix
    ./shared/overlays.nix

    ./system # default.nix
    ./system/bluetooth.nix
    ./system/common/packages.nix
    ./system/common/user.nix
    ./system/gaming # default.nix
    ./system/gaming/minecraft.nix
    ./system/gaming/steam.nix
    ./system/graphical # default.nix
    ./system/graphical/fonts.nix
    ./system/graphical/packages.nix
    ./system/graphical/sound.nix
    ./system/services/evremap.nix
    ./system/services/ollama.nix
    ./system/services/openrgb.nix
    ./system/services/ssh.nix
  ];

  # hm.imports = [ ./vars ];
}
