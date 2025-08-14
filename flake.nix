{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, deploy-rs, ... }@flake-inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSupportedSystems = self.lib.forAllSystems supportedSystems;

      config = {
        inherit flake-inputs;

        username = "hugobd";
      };

      nomad = (import ./nomad) config;
      tartelette = (import ./tartelette) config;
      hertaModule = import ./herta;
      mkHerta = i: (hertaModule { inherit flake-inputs; index = i; hostname = "herta-${toString i}"; });

    in
    {
      nixosModules = import ./nixosModules;
      hmModules = import ./hmModules;

      data = import ./data;

      lib = (import ./lib flake-inputs) // {
        hetzner = import ./hetzner;
      };

      nixosConfigurations.nomad = nomad.nixosConfiguration;
      nixosConfigurations.tartelette = tartelette.nixosConfiguration;
      nixosConfigurations.herta-1 = mkHerta 1;
      nixosConfigurations.herta-2 = mkHerta 2;
      nixosConfigurations.herta-3 = mkHerta 3;

      homeConfigurations.nomad = nomad.homeConfiguration;

      packages.aarch64-linux.tarteletteSDImage = tartelette.nixosSDImage;

      formatter = forAllSupportedSystems ({ pkgs, ... }: pkgs.nixfmt-rfc-style);

      devShells = forAllSupportedSystems (
        { pkgs, ... }:
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              pkgs.deploy-rs
              nixfmt-classic
              nil
            ];
          };
        }
      );

      packages.x86_64-linux = import ./packages flake-inputs;

      inherit flake-inputs;

      deploy = {
        nodes = {
          tartelette = {
            sshUser = "hugobd";
            hostname = "tartelette";
            profilesOrder = [
              "system"
              "home"
            ];

            profiles = {
              system = {
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.tartelette;
              };

              home = {
                path = deploy-rs.lib.x86_64-linux.activate.home-manager self.homeConfigurations.tartelette;
              };
            };
          };
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      templates = import ./templates flake-inputs;
    };
}
