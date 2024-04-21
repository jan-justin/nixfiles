{ config, lib', pkgs, ... }: with lib'; templated.preset "wayland" {
  inherit config;
  whenEnabled = {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      grim
      mpv
      mpvpaper
      satty
      slurp
      wl-clipboard
      wl-screenrec
      wlr-randr
    ];

    security.rtkit.enable = true;
    services.pipewire.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.alsa.support32Bit = true;
    services.pipewire.pulse.enable = true;
  };
}
