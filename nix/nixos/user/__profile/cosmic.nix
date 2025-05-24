{ ... }@_haumeaArgs:
{ config, lib, ... }@_hmModuleArgs: {
  options.cosmic.ext.launcher.plugin.web = lib.mkOption
    {
      type = lib.types.lines;
      default = "";
    };

  config = {
    cosmic.ext.launcher.plugin.web = ''
      (
          matches: ["nixopts"],
          queries: [(name: "NixOS Options", query: "search.nixos.org/options?channel=unstable&query=" )]
      ),
      (
          matches: ["nixpkgs"],
          queries: [(name: "Nix Packages", query: "search.nixos.org/packages?channel=unstable&query=" )]
      ),
      (
          matches: ["nixwiki"],
          queries: [(name: "Nix Wiki", query: "wiki.nixos.org/w/index.php?search=" )]
      ),
    '';

    xdg.dataFile."pop-launcher/plugins/web/config.ron".text = ''
      (
        rules: [
          ${config.cosmic.ext.launcher.plugin.web}
        ]
      )
    '';
  };
}
