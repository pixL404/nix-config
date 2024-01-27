{
  description = "System Flake for my machines (now only kosmo)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # various theming 
    catppuccin-vsc.url = "github:catppuccin/vscode";
    # catppuccin-sddm = {
    #   # url = "github:h4m6urg1r/catppuccin-sddm-flake";
    #   url = "path:/home/alex/devel/nix/catppuccin-sddm-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, hyprland, ... }@inputs:
  let
    system = "x86_64-linux";
    inherit (self) outputs;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.catppuccin-vsc.overlays.default
      ];
    };
  in
  {
    nixosConfigurations = {
      # laptop
      kosmo = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs pkgs system; };
        modules = [
          { nixpkgs.hostPlatform = nixpkgs.lib.mkDefault system; }

          # catppuccin-sddm.nixosModules.default {
          #   options = {
          #     theme = "frappe";
          #     font = "Helvetica Neue";
          #     fontSize = 11;
          #     clockEnabled = true;
          #     customBackground = false;
          #     loginBackground = false;
          #     background = "https://raw.githubusercontent.com/Gingeh/wallpapers/main/minimalistic/dark-cat-rosewater.png";
          #   };
          # })

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
              users.alex = import ./hosts/wanda/home.nix;
              extraSpecialArgs = { inherit inputs system pkgs ; };
           };
          }
        ];
      };
    };
  };
}
