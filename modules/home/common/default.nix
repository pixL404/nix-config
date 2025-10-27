{
  config,
  lib,
  ...
}:
{
  hm.config = lib.mkIf config.custom.enableHome {
    home = {
      username = "alex";
      homeDirectory = lib.mkForce "/home/alex";
    };

    # TODO: adjust for work wsl home-flake in the future
    programs.git = {
      enable = true;
      settings = {
        user.name = "alex";
        user.email = "alexostresso@gmail.com";

        # default = merge
        pull.rebase = false;
      };
    };

    programs.zellij = {
      enable = true;
      enableFishIntegration = false;
    };

    programs.direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
