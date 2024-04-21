{ config, lib', ... }: with lib'; templated.preset "kde" {
  inherit config;
  whenEnabled = {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = config.presets.wayland.enable;
  };
}
