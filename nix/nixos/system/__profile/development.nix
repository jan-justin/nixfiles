{ ... }@_haumeaArgs:
{ pkgs, ... }@_nixosModuleArgs: {
  environment.systemPackages = with pkgs; [
    devenv
    difftastic
    fd
    just
    jq
    poppler
    ripgrep
    theme-sh
    unar
  ];

  nix.settings.substituters = [
    "https://devenv.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];
}
