{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./openrgb
  ];
  # video driver
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    lact
  ];
}