{
  lib,
  ...
}:
with lib;
{
  options = {
    custom = {
      enableGraphical = mkEnableOption "graphical apps (no DE)";
      enableHome = mkEnableOption "managed home & shell";
      isWorkMachine = mkEnableOption "utilities needed at work";

      gaming.enable = mkEnableOption "gaming apps";
      services = {
        openssh.enable = mkEnableOption "OpenSSH";
      };

      hardware = {
        enable = mkEnableOption "the setting of hardware/system features";
      };
    };
    graphical = {
      develop.enable = mkEnableOption "";
      obs.enable = mkEnableOption "obs used for screen recording via replay buffer";
    };
  };
}
