{ cell, inputs }@_stdArgs: {
  "x86_64-linux" = {
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
