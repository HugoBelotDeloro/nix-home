{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    deploy-rs.url = "github:serokell/deploy-rs";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, deploy-rs, ... } @ flake-inputs:
    let
      pkgs = flake-inputs.nixpkgs.legacyPackages.x86_64-linux;

      config = {
        inherit flake-inputs;

        username = "hugobd";
      };

      nomad = (import ./nomad) config;
      tartelette = (import ./tartelette) config;

    in {
      nixosModules = import ./nixosModules;
      hmModules = import ./hmModules;

      data = import ./data;

      nixosConfigurations.nomad = nomad.nixosConfiguration;
      nixosConfigurations.tartelette = tartelette.nixosConfiguration;

      homeConfigurations.nomad = nomad.homeConfiguration;

      packages.aarch64-linux.tarteletteSDImage = tartelette.nixosSDImage;

      formatter.x86_64-linux = pkgs.nixfmt;

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [ pkgs.deploy-rs nixfmt nil ];
      };

      packages.x86_64-linux = import ./packages flake-inputs;

      deploy = {
        nodes = {
          tartelette = {
            sshUser = "hugobd";
            hostname = "tartelette";
            profilesOrder = [ "system" "home" ];

            profiles = {
              system = {
                path = deploy-rs.lib.x86_64-linux.activate.nixos
                  self.nixosConfigurations.tartelette;
              };

              home = {
                path = deploy-rs.lib.x86_64-linux.activate.home-manager
                  self.homeConfigurations.tartelette;
              };
            };
          };
        };
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      templates = import ./templates;
    };
}
