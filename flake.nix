{
  description = "Nix-based system configuration";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    devenv.url = "github:cachix/devenv";

    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nonstd.url = "github:vantonder/nonstd";
    nonstd.inputs.haumea.follows = "haumea";
    nonstd.inputs.nixpkgs.follows = "nixpkgs";
    nonstd.inputs.std.follows = "std";

    nur.url = "github:nix-community/nur";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, nonstd, self, std, ... }@inputs:
    std.growOn
      {
        inherit inputs;
        cellsFrom = ./nix;
        cellBlocks = [
          # nixos
          (std.blockTypes.functions "host")
          (std.blockTypes.functions "system")
          (std.blockTypes.functions "user")
          # support
          (std.blockTypes.functions "lib")
          (std.blockTypes.functions "shell")
        ];
      }
      {
        devShells = std.harvest self [ "support" "shell" ];
        nixosConfigurations = nonstd.lib.std.system."x86_64" self [ "nixos" "system" ];
      };
}
