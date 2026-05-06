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
    home.stateVersion = lib.mkForce "25.05";
    # extraSpecialArgs = { inherit inputs inputs' pkgs; };
  };
}
