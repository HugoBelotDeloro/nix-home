{ nixpkgs, nixos-hardware, nixosModules, homeModules }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./containers
    nixosModules.syncthing
    nixos-hardware.nixosModules.framework-12th-gen-intel
  ];

  specialArgs = {
    username = "hugobd";
    hostname = "framework-nixos";
  };
}
