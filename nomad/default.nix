{ username, data, flake-inputs }:

let
  system = "x86_64-linux";
  hostname = "framework-nixos";
in {
  nixosConfiguration = flake-inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./system
      flake-inputs.self.nixosModules.syncthing
      flake-inputs.aagl.nixosModules.default
      flake-inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ];

    specialArgs = { inherit username hostname data flake-inputs; };
  };

  homeConfiguration = flake-inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = flake-inputs.nixpkgs.legacyPackages.${system};

    modules = [ ./home.nix flake-inputs.nix-doom-emacs.hmModule ];

    extraSpecialArgs = {
      inherit username flake-inputs;
    };
  };
}
