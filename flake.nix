{
  description = "System Flake for my machines (now only kosmo)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url =  "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";

    };

    # various theming 
    # catppuccin-vsc.url = "github:catppuccin/vscode";
    sddm-catppuccin = {
      url = "github:khaneliman/sddm-catppuccin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nixvim, ... }@inputs:
  let
    system = "x86_64-linux";
    inherit (self) outputs;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        # inputs.catppuccin-vsc.overlays.default
      ]
      ++ (import ./overlays);
    };
  in
  {
    nixosConfigurations = {
      # laptop
      kosmo = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs pkgs system; };
        modules = [
          { nixpkgs.hostPlatform = nixpkgs.lib.mkDefault system; }

          ./hosts/kosmo 

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.alex = import ./hosts/kosmo/home.nix;
              extraSpecialArgs = { inherit inputs system pkgs ; };
           };
          }
        ];
      };

      # desktop PC
      wanda = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs pkgs system; };
        modules = [
          { nixpkgs.hostPlatform = nixpkgs.lib.mkDefault system; }
        
          ./hosts/wanda

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.alex = import ./hosts/wanda/home.nix;
              extraSpecialArgs = { inherit inputs system pkgs ; };
           };
          }
        ];
      };
    };
  };
}
