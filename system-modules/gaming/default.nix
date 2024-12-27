{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./minecraft.nix
    ./steam.nix

    # try to fix online matches for Dragon Ball Sparking! Zero
    # ./dbsz-test.nix
  ];

  # programs/launcher without special needs
  environment.systemPackages = with pkgs; [
    ryujinx
    dolphin-emu
    heroic

    lutris
    wineWow64Packages.unstableFull
    winetricks
  ];
}