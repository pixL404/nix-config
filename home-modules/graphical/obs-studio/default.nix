{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkMerge [
    { }

    (lib.mkIf (osConfig.networking.hostName == "wanda") {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-pipewire-audio-capture
          obs-vaapi
        ];
      };

      home.packages = with pkgs; [ kdePackages.kdenlive ];
    })
  ];
}
