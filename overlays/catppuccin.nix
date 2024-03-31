[
  (my: pkgs: {
    waybar-catppuccinColors = builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/waybar/57d8d020a0c9aa3dd8038f9acb31ed8c7e2a78c6/themes/frappe.css";
      # hash of the nix derivation, not the git commit hash
      hash = "sha256-PkrBXymbwYWsdWV0nP+RRZtLAKwXOJOstLKDgrPnOtg=";
    });

    foot-catppuccinColors = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/foot/4e5b4a78dec83b1778e01556f15cabd9c8c9ed4f/catppuccin-frappe.conf";
      hash = "sha256-5KjNdz4jpRzvB/UJjcMRBJYbTy4JHlUcfsiewo4ANME=";
    };

    hyprland-catppuccinColors = builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/hyprland/99a88fd21fac270bd999d4a26cf0f4a4222c58be/themes/frappe.conf";
      hash = "sha256-knpSjUKtQ1tsOotTi/e+OMdHCchgBI3tSa148dF3UqA=";
    });

    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "lavender" ];
      size = "standard";
      variant = "frappe";
    };
    
    catppuccin-vsc = pkgs.catppuccin-vsc.override {
      accent = "lavender";
      boldKeywords = true;
      italicComments = true;
      italicKeywords = true;
      extraBordersEnabled = false;
      workbenchMode = "default";
      bracketMode = "rainbow";
      colorOverrides = {};
      customUIColors = {};
    };
  })
]