{ inputs, ... }@_haumeaArgs:
{ lib, pkgs, ... }@_nixosModuleArgs: {
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
  hardware.xpadneo.enable = true;

  programs.gamemode.enable = true;

  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;

  programs.steam.enable = true;
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.gamescopeSession.args = [
    "-W 3840"
    "-w 3840"
    "-H 1600"
    "-h 1600"
    "-r 119"
    "--hdr-enabled"
    "--mangoapp"
  ];
  programs.steam.gamescopeSession.steamArgs = [
    "-pipewire-dmabuf"
    "-gamepadui"
    "-steamos3"
    "-steampal"
  ];
}
