{ ... }@_haumeaArgs:
{ config, pkgs, ... }@_nixosModuleArgs: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    mpv
    wl-clipboard
    wlr-randr
  ];

  services.displayManager.enable = true;

  services.greetd.enable = true;

  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
}
