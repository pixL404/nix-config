{
  config,
  pkgs,
  lib,
  ...
}:
{
  fonts = lib.mkIf config.custom.enableGraphical {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      font-awesome
      open-sans
      fira-code
      fira-code-symbols
      jetbrains-mono
      helvetica-neue-lt-std
      nerd-fonts.symbols-only
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Open Sans" ];
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "JetBrains Mono" ];
    };
    enableDefaultPackages = true;
  };
}
