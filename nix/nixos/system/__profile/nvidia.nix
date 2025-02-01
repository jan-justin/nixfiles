{ ... }@_haumeaArgs:
{ config, pkgs, ... }@_nixosModuleArgs: {
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  environment.variables.__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  environment.variables.GBM_BACKEND = "nvidia-drm";
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  services.xserver.videoDrivers = [ "nvidia" ];
}
