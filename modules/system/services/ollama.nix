{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.custom.AI;
in
{
  options.custom.AI.enable = lib.mkEnableOption "Self-Hosted AI Chat";
  config = lib.mkIf cfg.enable {
    nixpkgs.config.rocmSupport = true;
    services = {
      ollama = {
        enable = true;
        acceleration = "rocm";

        home = "/data/ai/ollama";

        # https://github.com/NixOS/nixpkgs/issues/308206
        # https://rocm.docs.amd.com/en/latest/reference/gpu-arch-specs.html
        rocmOverrideGfx = "11.0.1"; # gfx1101

        host = "127.0.0.1";
        port = 11434;
        openFirewall = false;
      };

      open-webui = {
        enable = true;
        port = 8080;

        environment = {
          OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
          # Disable authentication
          WEBUI_AUTH = "False";
        };
      };

    };

    # nixos-containers didn't work => use a wrapper service to start/stop them
    systemd.services = {
      my-ollama = {
        wants = [
          "ollama.service"
          "open-webui.service"
        ];
        upholds = [
          "ollama.service"
          "open-webui.service"
        ];

        wantedBy = [ ]; # empty so it doesnt auto start

        script = ''
          while true;
          do
            ${pkgs.coreutils}/bin/echo hello ollama
            sleep 60m
          done
        '';
      };
      ollama = {
        requires = lib.mkForce [ "my-ollama.service" ];
        wantedBy = lib.mkForce [ ];
        upheldBy = lib.mkForce [ ];
      };
      # nextjs-ollama-llm-ui = {
      open-webui = {
        requires = lib.mkForce [ "my-ollama.service" ];
        wantedBy = lib.mkForce [ ];
        upheldBy = lib.mkForce [ ];
      };
    };
  };
}

# didnt work
#   containers.ollama = {
#     autoStart = false;
#     privateNetwork = false;

#     restartIfChanged = true;
#     timeoutStartSec = "5min";

#     allowedDevices = [
#       {
#         node = "/dev/dri";
#         modifier = "rwm";
#       }
#       {
#         node = "/dev/dri";
#         modifier = "rwm";
#       }
#     ];

#     bindMounts = {
#       "/data" = {
#         hostPath = "/data/ollama/";
#         isReadOnly = false;
#       };

#       "/dev/dri" = {
#         hostPath = "/dev/dri";
#         isReadOnly = false;
#       };

#       "/dev/kfd" = {
#         hostPath = "/dev/kfd";
#         isReadOnly = false;
#       };

#       "/sys/class/kfd/kfd/topology/nodes" = {
#         hostPath = "/sys/class/kfd/kfd/topology/nodes";
#         isReadOnly = false;
#       };

#       "/sys/class/drm" = {
#         hostPath = "/sys/class/drm";
#         isReadOnly = false;
#       };

#       "/sys/module/amdgpu" = {
#         hostPath = "/sys/module/amdgpu";
#         isReadOnly = false;
#       };

#     };

#     forwardPorts = {
#       containerPort = 8080;
#       hostPort = 80;
#       protocol = "tcp";
#     };

#     config = {
#       system.stateVersion = "unstable";
#       nixpkgs.config.rocmSupport = true;
#       users.users.ollama = {
#         isNormalUser = true;
#         home = "/data";
#         group = "render";
#       };

###
# ollama config would go here
###

#       services.xserver.videoDrivers = [ "modesetting" ];
#       boot.kernelModules = [ "amdgpu" ];
#       boot.initrd.kernelModules = [ "amdgpu" ];
#       hardware.amdgpu.opencl.enable = true;
#       hardware.graphics = {
#         enable = true;
#         enable32Bit = true;
#         extraPackages = [ pkgs.rocmPackages.clr.icd ];
#       };

#       environment.systemPackages = with pkgs; [
#         rocmPackages.clr.icd
#       ];

#       systemd.tmpfiles.rules = [
#         "L+    /opt/rocm   -    -    -     -    ${pkgs.rocmPackages.clr}"
#         "L+    /opt/rocm   -    -    -     -    ${pkgs.rocmPackages.rocblas}"
#       ];

#     }
#   };
# }
