{
  config,
  pkgs,
  home-manager,
  inputs,
  ...
}:
{
  imports = [
      # hardware scan
      ./hardware.nix

      inputs.nixos-hardware.nixosModules.common-cpu-amd
      inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
      # not needed - got dedicated graphics
      # inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu

      inputs.nixos-hardware.nixosModules.common-pc-ssd

      ../../system-modules/desktop

      ../../system-modules/common
      ../../system-modules/graphical
      ../../system-modules/bluetooth
      ../../system-modules/ssh

      ../../system-modules/misc/vim.nix
      ../../system-modules/misc/mouse-remap.nix

      ../../system-modules/gaming
      ../../system-modules/wife

      ../../system-modules/develop/android
  ];

  networking.hostName = "wanda";

  # enable nixos-containers (e.g. minecraft server)
  boot.enableContainers = true;

  # Define user account.
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "libvirtd" ];
    shell = pkgs.fish;
  };
}
