[
  (my: pkgs: {

    catppuccin-vsc = pkgs.catppuccin-vsc.override {
      accent = "lavender";
      boldKeywords = true;
      italicComments = true;
      italicKeywords = true;
      extraBordersEnabled = false;
      workbenchMode = "default";
      bracketMode = "rainbow";
      colorOverrides = { };
      customUIColors = { };
    };
  })
]
