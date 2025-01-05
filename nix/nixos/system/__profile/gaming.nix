{ ... }@_haumeaArgs:
{ ... }@_nixosModuleArgs: {
  programs.gamemode.enable = true;

  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;

  programs.steam.enable = true;
}
