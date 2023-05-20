{ nixpkgs, nixos-hardware, systemModules, homeModules }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    nixos-hardware.nixosModules.framework-12th-gen-intel
  ];

  specialArgs = {
    username = "hugobd";
    hostname = "framework-nixos";
  };
}
