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
          (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "alex" ])
          # ../modules/home
          ../modules
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
          inputs.home-manager.nixosModules.home-manager
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
