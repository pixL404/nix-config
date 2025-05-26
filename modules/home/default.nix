{
  inputs,
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
    home.stateVersion = "25.05";
    # extraSpecialArgs = { inherit inputs inputs' pkgs; };
  };
}
