{
  config,
  pkgs,
  home-manager,
  ...
}:
{
  imports = [
      # laptop specific settings
      ./hardware.nix
      ../../system-modules/laptop

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