{
  config,
  pkgs,
  ...
}:
{
  imports = [
    # ./openrgb
  ];

  # support for radeon GPU
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  boot.modprobeConfig.enable = true;
  environment.etc."modprobe.d/99-amdgpu-overdrive.conf".text =
    ''
      options amdgpu ppfeaturemask=0xFFF7FFFF
    '';

  environment.systemPackages = with pkgs; [
    amdgpu_top
    lact
  ];
}