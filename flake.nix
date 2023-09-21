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
    deploy-rs.url = "github:serokell/deploy-rs";
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, deploy-rs
    , nix-doom-emacs, aagl, }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      config = {
        inherit nixpkgs nixos-hardware home-manager;

        username = "hugobd";
        nixosModules = (import ./nixosModules) // {
          aagl = aagl.nixosModules.default;
        };
        homeModules = (import ./homeModules) // {
          nix-doom-emacs = nix-doom-emacs.hmModule;
        };
        data = import ./data;
      };

      nomad = (import ./nomad) config;
      tartelette = (import ./tartelette) config;

    in {
      nixosConfigurations.nomad = nomad.nixosConfiguration;
      nixosConfigurations.tartelette = tartelette.nixosConfiguration;

      homeConfigurations.nomad = nomad.homeConfiguration;
      homeConfigurations.tartelette = tartelette.homeConfiguration;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [ pkgs.deploy-rs nixfmt nil ];
      };

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
    };
}
