{ cell, name, super, ... }@_haumeaArgs: {
  host = cell.host.${name};

  profiles = [
    super.profile.cosmic
    super.profile.development
    super.profile.laptop
    super.profile.wayland
  ];

  users = [
    cell.user.uniform
  ];
}
