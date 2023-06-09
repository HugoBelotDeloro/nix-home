{ nixpkgs, nixos-hardware, home-manager, nixosModules, homeModules }:

let
  system = "x86_64-linux";
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
      username = "hugobd";
      hostname = "framework-nixos";
    };
  };

  homeConfiguration = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};

    modules = [
      ./home.nix
      homeModules.nix-doom-emacs
    ];

    extraSpecialArgs = {
      inherit homeModules;
    };
  };
}
