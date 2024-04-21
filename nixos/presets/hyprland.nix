{ config, lib', pkgs, ... }: with lib'; templated.preset "hyprland" {
  inherit config;
  whenEnabled = {
    environment.systemPackages = with pkgs; [ grimblast ];

    environment.sessionVariables.__GLX_VENDOR_LIBRARY_NAME = "nvidia";
    environment.sessionVariables.GBM_BACKEND = "nvidia-drm";
    environment.sessionVariables.LIBVA_DRIVER_NAME = "nvidia";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
    environment.sessionVariables.XDG_SESSION_TYPE = "wayland";

    programs.hyprland.enable = true;
  };
}
