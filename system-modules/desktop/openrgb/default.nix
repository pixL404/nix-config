{
  config,
  pkgs,
  ...
}:
let
  myOpenrgb = pkgs.openrgb.overrideAttrs (old: {
    version = "git";
    src = pkgs.fetchFromGitLab {
      owner = "CalcProgrammer1";
      repo = "OpenRGB";
      rev = "1a68abc8a074a90f03ef6f164eca37fbdd4cb95b";
      hash = "sha256-8QXkTxc97JUIdfuBsNb7jRTeidMAeT4znj+FYlOOkYo=";
    };
  });

  # rules-text = builtins.readFile pkgs.fetchurl {
  #   url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+64+AppImage&inline=false";
  #   hash = "sha256-z4sLh/F2igH/RBnb2hXHh5RA0SDVsNMICG22iK4RQYU=";
  # };
  # openrgb-rules = builtins.replaceStrings [ "/bin/chmod" ] [ "${pkgs.coreutils}/bin/chmod" ] rules-text;
in
{
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  hardware.i2c.enable = true;
  # services.udev.extraRules = openrgb-rules;
  services.udev.packages = [ myOpenrgb ];
  services.hardware.openrgb = {
    enable = true;
    package = myOpenrgb;
    motherboard = "amd";
  };

  environment.systemPackages = with pkgs; [
    # openrgb-with-all-plugins
    # myOpenrgb
    i2c-tools
  ];
}