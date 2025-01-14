flake-inputs:

flake-inputs.nixpkgs.lib.nixosSystem (
  flake-inputs.self.lib.mkVmConfiguration {
    system = "x86_64-linux";
    sshHostPort = 2222;
    inherit flake-inputs;
})
