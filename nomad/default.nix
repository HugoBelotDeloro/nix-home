{ nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, nixosModules
, homeModules, username, data, }:

let
  system = "x86_64-linux";
  hostname = "framework-nixos";
in {
  nixosConfiguration = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./system
      nixosModules.syncthing
      nixosModules.aagl
      nixos-hardware.nixosModules.framework-12th-gen-intel
    ];

    specialArgs = { inherit username hostname data; };
  };

  homeConfiguration = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};

    modules = [ ./home.nix homeModules.nix-doom-emacs ];

    extraSpecialArgs = {
      inherit homeModules username nixpkgs nixpkgs-unstable;
    };
  };
}
