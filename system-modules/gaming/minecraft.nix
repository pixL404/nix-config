{
  config,
  pkgs,
  ...
}:
let
  minecraft-server-1-19-2 = pkgs.minecraftServers.vanilla-1-19.overrideAttrs (old: {
    version = "1.19.2";
    src = pkgs.fetchurl {
      url = "https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar";
      sha1 = "f69c284232d7c7580bd89a5a4931c3581eae1378";
    };
  });
in
{

  environment.systemPackages = with pkgs; [
    prismlauncher
    jdk17
  ];

  # TODO: enable this on self-defined flag
  networking.firewall.allowedTCPPorts = [ 25565 ];
  containers.minecraft-server = {
    autoStart = false;
    privateNetwork = false;

    # so the server doesn't stop if I change my config
    restartIfChanged = false;
    timeoutStartSec = "5min";
    forwardPorts = {
      containerPort = 25565;
      hostPort = 25565;
      protocol = "tcp";
    };

    bindMounts = {
      "/data" = {
        hostPath = "/data/minecraft/server/";
        isReadOnly = false;
      };
    };
    
    config = {
      services.minecraft-server = {
        enable = true;
        eula = true;
        package = minecraft-server-1-19-2;
        jvmOpts = "-Xms10G -Xmx12G -XX:+UseG1GC";
        dataDir = "/data";
        declarative = false;
      };
    system.stateVersion = "24.05";
    };
  };
}
