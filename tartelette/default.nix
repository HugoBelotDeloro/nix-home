{ nixpkgs, nixos-hardware, home-manager, nixosModules, homeModules }:

let
  system = "aarch64-linux"
  hostname = "tartelette";
  username = "hugobd";
in
{
  nixosConfiguration = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./system
      nixos-hardware.nixosModules."raspberry-pi-4"
    ];

    specialArgs = {
      inherit username hostname;
    };
  };
}
