{
  inputs,
  lib,
  ...
}:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  custom = {
    enableHome = true;
    isWorkMachine = true;
  };

  hm.home.stateVersion = lib.mkForce "25.05";

  imports = [
    inputs.home-manager.nixosModules.default
  ];
}
