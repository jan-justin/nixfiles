{ inputs, lib' }: {
  nixos = import ./nixos { inherit inputs lib'; };  
}
