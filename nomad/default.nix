{ nixpkgs, nixos-hardware, home-manager, nixosModules, homeModules }:

let
  system = "x86_64-linux";
  hostname = "framework-nixos";
  username = "hugobd";
in
{
  nixosConfiguration = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./system
      nixosModules.syncthing
      nixos-hardware.nixosModules.framework-12th-gen-intel
    ];

    specialArgs = {
      inherit username hostname;
    };
  };

  homeConfiguration = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};

    modules = [
      ./home.nix
      homeModules.nix-doom-emacs
    ];

    extraSpecialArgs = {
      inherit homeModules username;
    };
  };
}
