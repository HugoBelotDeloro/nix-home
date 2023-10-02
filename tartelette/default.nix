{ nixpkgs, username, data, flake-inputs }:

let
  system = "aarch64-linux";
  hostname = "tartelette";
in {
  nixosConfiguration = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./system
      flake-inputs.self.nixosModules.syncthing
      flake-inputs.nixos-hardware.nixosModules."raspberry-pi-4"
    ];

    specialArgs = { inherit username hostname data flake-inputs; };
  };

  homeConfiguration = flake-inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};

    modules = [ ./home.nix flake-inputs.nix-doom-emacs.hmModule ];

    extraSpecialArgs = { inherit username flake-inputs; };
  };
}
