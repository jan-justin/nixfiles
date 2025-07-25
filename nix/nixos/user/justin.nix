{ name, super, ... }@_haumeaArgs:
{ ... }@_nixosModuleArgs:
{
  imports = [
    # Remove some boilerplate
    (super.pc-user {
      tag = "Personal";
      username = name;
    })
  ];

  home-manager.users.${name} = {
    imports = [
      super.profile.cosmic
      super.profile.development
      super.profile.gaming
    ];

    programs.git.extraConfig.user.signingKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCIGXttA+0HUZtaya0T2klbNSrxonbJ8BEmi4L8+/MM";

    programs.jujutsu.settings.signing.key =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCIGXttA+0HUZtaya0T2klbNSrxonbJ8BEmi4L8+/MM";
  };
}
