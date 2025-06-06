{ pkgs, config, ... }:
{
  hm.programs.foot = {
    enable = config.custom.enableGraphical;
    package = pkgs.foot;
    server.enable = true;
    settings = {
      main = {
        term = "foot";

        font = "monospace:size=11, font-awesome:size=11, emoji:size=11";
        dpi-aware = "no";

        pad = "4x4";

        bold-text-in-bright = "yes";
        selection-target = "both";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
      };

      scrollback = {
        indicator-format = "percentage";
      };

      cursor = {
        style = "block";
        blink = "no";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      colors = {
        alpha = 0.8;
      };
    };
  };
}
