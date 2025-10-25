{ inputs, name, super, ... }@_haumeaArgs:
{ config, lib, pkgs, ... }@_nixosModuleArgs: {
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

    programs.firefox.profiles.default.settings."browser.ml.chat.provider" = "https://gemini.google.com";

    programs.git.settings.user.signingKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRTP702lUz73eZnq5TZXdkb2AkNvJbNuHLBXt42kv66";

    programs.jujutsu.settings.signing.key =
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

  services.netbird.enable = true;

  systemd.services.wazuh = {
    description = "Sets up wazuh container";
    after = [ "network.target" "network-online.target" ];
    wants = [ "network.target" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "systemd-nspawn --keep-unit --boot -D /var/lib/machines/whiskey";
    };
  };

  systemd.targets.multi-user.wants = [
    "ovpn.service"
    "wazuh.service"
  ];

  users.users.${name}.extraGroups = [ "docker" ];

  virtualisation.docker.enable = true;
}
