{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.custom.gaming.enable {
    services.flatpak.enable = true;

    # programs/launcher without special needs
    environment.systemPackages = with pkgs; [
      ryubing
      dolphin-emu
      # TODO: temporarily broken
      # rpcs3

      heroic

      lutris
      wineWow64Packages.unstableFull
      winetricks
    ];
  };
}
