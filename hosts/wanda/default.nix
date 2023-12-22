{
  config,
  pkgs,
  home-manager,
  nixos-hardware,
  ...
}:
{
  imports = [
      # laptop specific settings
      # ./hardware.nix

      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-cpu-amd-pstate
      nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu

      nixos-hardware.nixosModules.common-pc-ssd

      ../../system-modules/common
      ../../system-modules/graphical
      ../../system-modules/bluetooth

      ../../system-modules/misc/vim.nix
  ];

  networking.hostName = "kosmo";

  # Define user account.
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];
    shell = pkgs.fish;
  };
}