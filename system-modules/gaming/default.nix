{ config, pkgs, ... }:
{
  imports = [
    ./minecraft.nix
    ./steam.nix

    # try to fix online matches for Dragon Ball Sparking! Zero
    # ./dbsz-test.nix
  ];

  services.flatpak.enable = true;

  # programs/launcher without special needs
  environment.systemPackages = with pkgs; [
    # ryujinx
    ryubing
    dolphin-emu
    rpcs3

    heroic

    lutris
    wineWow64Packages.unstableFull
    winetricks
  ];
}
