{ inputs, name, super, ... }@_haumeaArgs:
{ config, pkgs, ... }@_nixosModuleArgs: {
  imports = [
    # Remove some boilerplate
    (super.pc-user {
      tag = "Formelio";
      username = name;
    })
  ];

  home-manager.users.${name} = {
    imports = [
      super.profile.cosmic
      super.profile.development
    ];

    cosmic.ext.launcher.plugin.web = ''
      (
          matches: ["formelio/gh"],
          queries: [(name: "Formelio GitHub Org", query: "github.com/search?q=org:formelio " )]
      ),
    '';

    home.packages = with pkgs; [
      google-cloud-sdk
      jetbrains.idea-community-bin
      kubectl
      kubelogin-oidc
      slack
      sops
      yaml-language-server

      (wrapHelm kubernetes-helm {
        plugins = [
          kubernetes-helmPlugins.helm-secrets
        ];
      })
    ];

    programs.git.extraConfig.user.signingKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRTP702lUz73eZnq5TZXdkb2AkNvJbNuHLBXt42kv66";

    programs.java.enable = true;
    programs.java.package = pkgs.jdk17;

    programs.k9s.enable = true;
    programs.k9s.settings = {
      k9s = {
        shellPod = {
          image = "nixos/nix";
          namespace = "default";
          limits = {
            cpu = "100m";
            memory = "200Mi";
          };
        };
        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 85;
          };
        };
        ui = {
          logoless = true;
          reactive = true;
        };
      };
    };
  };

  programs.openvpn3.enable = true;
  programs.openvpn3.package = inputs.nixpkgs-stable.legacyPackages.openvpn3;
}
