{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  hm = {
    home.stateVersion = lib.mkForce "25.05";
    # extraSpecialArgs = { inherit inputs inputs' pkgs; };
  };
}
