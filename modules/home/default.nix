{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  hm = {
    home.stateVersion = "26.05";
    # extraSpecialArgs = { inherit inputs inputs' pkgs; };
  };
}
