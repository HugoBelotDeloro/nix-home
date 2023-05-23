{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, nixos-hardware }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    localConfig = import ./local-configs/framework.nix;
    username = "hugobd";

  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};

      modules = [
        ./home/home.nix
        ./local-configs/framework.nix
        nix-doom-emacs.hmModule
      ];
    };

    nixosConfigurations.framework-nixos = import ./nomad {
      inherit nixpkgs nixos-hardware;
      nixosModules = import ./nixosModules;
      homeModules = [];
    };

    nixosConfigurations.tartelette = import ./tartelette {
      inherit nixpkgs nixos-hardware;
      nixosModules = import ./nixosModules;
      homeModules = [];
    };
  };

}
