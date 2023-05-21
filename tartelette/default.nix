{ nixpkgs, nixos-hardware, nixosModules, homeModules }:

nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  modules = [
    ./configuration.nix
    ./hardware-configuration.nix
    nixos-hardware.nixosModules."raspberry-pi-4"
  ];

  specialArgs = {
    username = "hugobd";
    hostname = "tartelette";
  };
}
