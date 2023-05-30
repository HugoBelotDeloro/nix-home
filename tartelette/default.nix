{ nixpkgs, nixos-hardware, home-manager, nixosModules, homeModules }:

let
  system = "aarch64-linux"
in
{
  nixosConfiguration = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      nixos-hardware.nixosModules."raspberry-pi-4"
    ];

    specialArgs = {
      username = "hugobd";
      hostname = "tartelette";
    };
  };
}
