# add home-manager and import it
# import the home-manager configuration from ../home/home.nix

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    #<home-manager/nixos>
    (import "${home-manager}/nixos")
    #../home/home.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;

  home-manager.users.alex = {
#    programs.git = {
#      enable = true;
#      userName = "alex";
#      userEmail = "alexostresso@gmail.com";
#    };
     imports = [
       ../home/home.nix
     ];
  };
}
