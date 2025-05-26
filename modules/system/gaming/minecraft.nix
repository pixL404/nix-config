{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.custom.gaming;

  fabric-server-1-20-1 = pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: {
    version = "fabric-1.20.1";
    src = pkgs.fetchurl {
      url = "https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.11/1.0.1/server/jar";
      hash = "sha256-/j9wIzYSoP+ZEfeRJSsRwWhhTNkTMr+vN40UX9s+ViM=";
    };
  });
  minecraft-server-1-21 = pkgs.minecraftServers.vanilla-1-20.overrideAttrs (old: {
    version = "1.20.1";
    src = pkgs.fetchurl {
      url = "https://piston-data.mojang.com/v1/objects/59353fb40c36d304f2035d51e7d6e6baa98dc05c/server.jar";
      sha1 = "59353fb40c36d304f2035d51e7d6e6baa98dc05c";
    };
  });
in
{
  options = {
    custom.gaming.hostMineCraftServer = lib.mkEnableOption "a NixOS container that runs minecraft server";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
      # jdk17
      jdk21
    ];

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.hostMineCraftServer [ 25565 ];
    containers = lib.mkIf cfg.hostMineCraftServer {
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
            package = minecraft-server-1-21; # from overlay
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
  };
}
