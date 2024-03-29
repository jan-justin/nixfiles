{
  description = "Nix-based system configuration";

  nixConfig = {
    substituters = [ "https://cache.nixos.org/" ];
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/nur";
  };

  outputs = inputs:
    let
      lib' = import ./lib { inherit inputs; };
      outputs.nixos = import ./nixos { inherit inputs lib'; };
      outputs.shells = import ./shells { inherit inputs; };
    in {
      inherit (outputs.nixos) nixosConfigurations;
      inherit (outputs.shells) devShells;
    };
}
