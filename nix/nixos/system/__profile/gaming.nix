{ ... }@_haumeaArgs:
{ ... }@_nixosModuleArgs: {
  hardware.xpadneo.enable = true;

  programs.gamemode.enable = true;

  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;

  programs.steam.enable = true;
}
