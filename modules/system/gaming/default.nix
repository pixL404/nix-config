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

      # why the fuck does `lutris` build openldap???
      lutris-unwrapped
      wineWow64Packages.unstableFull
      winetricks
    ];
  };
}
