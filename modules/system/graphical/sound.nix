{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.custom.enableGraphical {
    # Enable sound.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;

      # extraConfig.pipewire = {
      #   "99-custom" = {
      #     "context.properties" = {
      #       "default.clock.rate" = 192000;
      #       "default.allowed-rates" = [ 192000 48000 44100 ];
      #       "resample.quality" = 10;
      #       "default.clock.quantum" = 32;
      #       "default.clock.min-quantum" = 32;
      #       "default.clock.max-quantum" = 32;
      #     };
      #   };
      # };
    };
  };
}
