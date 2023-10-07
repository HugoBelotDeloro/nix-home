{ username, flake-inputs }:

let
  system = "x86_64-linux";
  hostname = "framework-nixos";
in {
  nixosConfiguration = flake-inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [ ./system ];

    specialArgs = { inherit username hostname flake-inputs; };
  };

  homeConfiguration = flake-inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = flake-inputs.nixpkgs.legacyPackages.${system};

    modules = [ ./home ];

    extraSpecialArgs = { inherit username flake-inputs; };
  };
}
