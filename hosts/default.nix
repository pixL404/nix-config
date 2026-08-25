{
  inputs, # regular inputs coming from flake.nix
  withSystem,
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
        modules = modules ++ [ ../modules/home ];
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
    # formerly wanda
    talescria = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./talescria ];
    };
    # formerly kosmo
    thraxa = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./thraxa ];
    };
    viltrum = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./viltrum ];
    };
  };

  flake.homeConfigurations = {
    work = mkHomeConfiguration {
      system = "x86_64-linux";
      modules = [ ./work ];
    };
  };
}
