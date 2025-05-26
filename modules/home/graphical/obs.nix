{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.graphical.obs;
in
{
  hm.config = lib.mkIf config.graphical.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vaapi
      ];
    };

    home.packages = with pkgs; [ kdePackages.kdenlive ];
  };
}
