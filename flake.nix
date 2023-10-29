{
  description = "System Flake for my machines (now only kosmo)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
  let
    system = "x86_64-linux";
    inherit (self) outputs;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [];
    };
  in
  {
    nixosConfigurations = {
      kosmo = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs pkgs system; };
        modules = [
          { nixpkgs.hostPlatform = nixpkgs.lib.mkDefault system; }

          ./hosts/kosmo 

          hyprland.nixosModules.default {
            programs.hyprland = {
              enable = true;
              xwayland.enable = true;
            };
            #wayland.windowManager.hyprland.enable = true;
          }

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.alex = import ./hosts/kosmo/home.nix;
              extraSpecialArgs = { inherit inputs system pkgs; };
           };
          }
        ];
      };
    };
  };
}
