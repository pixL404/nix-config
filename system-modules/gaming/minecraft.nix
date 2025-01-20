{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkMerge [
    {
      environment.systemPackages = with pkgs; [
        prismlauncher
        # jdk17
        jdk21
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
              package = pkgs.minecraft-server-1-21; # from overlay
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
              package = pkgs.fabric-server-1-20-1; # from overlay
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
