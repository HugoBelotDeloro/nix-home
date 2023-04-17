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
    username = localConfig.username;

  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home/home.nix
        nix-doom-emacs.hmModule
      ];


      extraSpecialArgs = {
        extraPackages = localConfig.extraPackages;
      };
    };

    nixosConfigurations."framework-nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix
        # ./nixos/k3s.nix
        nixos-hardware.nixosModules.framework-12th-gen-intel
      ];
    };
  };

}
