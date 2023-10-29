
{
  config,
  pkgs,
  ...
}:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      open-sans
      fira-code
      fira-code-symbols
      jetbrains-mono
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
