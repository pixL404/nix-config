{
  inputs, # regular inputs coming from flake.nix
  withSystem,
  lib,
  ...
}:
let
  mkHomeConfiguration =
    {
      system,
      modules ? [ ],
      ...
    }:
    withSystem system (
      {
        inputs', # inputs with the correct system already applied
        config,
        pkgs,
        self',
        ...
      }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            inputs
            inputs'
            self'
            ;
        };
        modules = modules ++ [
          # ../modules/home
          ../modules
          { home.stateVersion = "25.05"; }
          inputs.home-manager.nixosModules.home-manager

          # import specific modules for home-manager flakes
          inputs.nixvim.homeModules.nixvim
        ];
      }
    );
  mkNixosSystem =
    {
      system,
      modules ? [ ],
      ...
    }:
    withSystem system (
      {
        inputs', # inputs with the correct system already applied
        config,
        pkgs,
        self',
        ...
      }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            inputs'
            system
            self'
            ;
        };
        modules = modules ++ [
          ../modules
          inputs.home-manager.flakeModules.home-manager

          # import specific modules for NixOS flakes
          inputs.nixvim.nixosModules.nixvim
          inputs.catppuccin.nixosModules.catppuccin
        ];
      }
    );
in
{
  flake.nixosConfigurations = {
    wanda = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./wanda ];
    };
    kosmo = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./kosmo ];
    };
  };

  flake.homeConfigurations = {
    work = mkHomeConfiguration {
      system = "x86_64-linux";
      modules = [ ./work ];
    };
  };
}
