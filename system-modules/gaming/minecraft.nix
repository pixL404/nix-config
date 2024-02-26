{
  config,
  pkgs,
  lib,
  ...
}:
let
  minecraft-server-1-20-1 = pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: {
    version = "1.20.1";
    src = pkgs.fetchurl {
      url = "https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar";
      sha1 = "84194a2f286ef7c14ed7ce0090dba59902951553";
    };
  });
  fabric-server-1-20-1 = pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: {
    version = "fabric-1.20.1";
    src = pkgs.fetchurl {
      url = "https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.6/1.0.0/server/jar";
      hash = "sha256-vOULXIe2hz5p49rdlXINsHYsl5whx6PQE0HnLxd6Vl0=";
    };
  });
in
{

  config = lib.mkMerge [
    {
      environment.systemPackages = with pkgs; [
        prismlauncher
        jdk17
      ];
    }

    # TODO: is this the best way?
    (lib.mkIf (config.networking.hostName == "wanda") {
      networking.firewall.allowedTCPPorts = [ 25565 ];
      containers = {
        minecraft-server = {
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
              package = minecraft-server-1-20-1;
              jvmOpts = "-Xms10G -Xmx12G -XX:+UseG1GC";
              dataDir = "/data";
              declarative = false;
            };
          system.stateVersion = "24.05";
          };
        };
        fabric-server = {
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
              hostPath = "/data/minecraft/fabric-server/";
              isReadOnly = false;
            };
          };
          
          config = {
            services.minecraft-server = {
              enable = true;
              eula = true;
              package = fabric-server-1-20-1;
              jvmOpts = "-Xms10G -Xmx12G -XX:+UseG1GC";
              dataDir = "/data";
              declarative = false;
            };
          system.stateVersion = "24.05";
          };
        };
      };
    })
  ];
}
