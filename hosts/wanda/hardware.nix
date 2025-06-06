{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  swapSize = 35 * 1024;
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-amd"
    "amdgpu"
  ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation_into_swap_file
  # first row & first entry in physical offset of:
  # sudo filefrag -v /.swapfile | head

  # 1st param: where is swapfile (see above)
  # 2nd param: enable amdgpu clock and voltage changes
  boot.kernelParams = [
    "resume_offset=4161536"
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  boot.resumeDevice = "/dev/disk/by-label/NIXROOT";

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/NIXHOME";
    fsType = "btrfs";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "btrfs";
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [
      "/home"
      "/data"
    ];
  };

  swapDevices = [
    {
      device = "/.swapfile";
      size = swapSize;
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp11s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp12s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # enable rocm support for running LLMs
  hardware.amdgpu.opencl.enable = true;
  hardware.graphics.extraPackages = [ pkgs.rocmPackages.clr.icd ];

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.corectrl = {
    enable = true;
  };
  hardware.amdgpu.overdrive.enable = true;
  boot.modprobeConfig.enable = true;
  environment.etc."modprobe.d/99-amdgpu-overdrive.conf".text = ''
    options amdgpu ppfeaturemask=0xFFF7FFFF
  '';

  environment.systemPackages = with pkgs; [
    amdgpu_top
    lact
    amdvlk
  ];
}
