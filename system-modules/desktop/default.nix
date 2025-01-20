{ config, pkgs, ... }:
{
  imports = [
    ./packages.nix

    ./openrgb
  ];

  # support for radeon GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
  };
  boot.modprobeConfig.enable = true;
  environment.etc."modprobe.d/99-amdgpu-overdrive.conf".text = ''
    options amdgpu ppfeaturemask=0xFFF7FFFF
  '';

  # keep it commented, incase i need a vm once
  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;
}
