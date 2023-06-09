{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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

    config = {
      inherit nixpkgs nixos-hardware home-manager;

      username = "hugobd";
      nixosModules = import ./nixosModules;
      homeModules = (import ./homeModules) // {
        nix-doom-emacs = nix-doom-emacs.hmModule;
      };
    };

    nomad = (import ./nomad) config;
    tartelette = (import ./tartelette) config;

  in {
    nixosConfigurations.nomad = nomad.nixosConfiguration;
    nixosConfigurations.tartelette = tartelette.nixosConfiguration;

    homeConfigurations.nomad = nomad.homeConfiguration;
  };
}
