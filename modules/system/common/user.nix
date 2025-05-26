{
  pkgs,
  ...
}:
{
  # Define user account.
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "libvirtd"
      "adbusers"
    ];
    shell = pkgs.fish;
  };
}
