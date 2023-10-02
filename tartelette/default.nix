{ username, flake-inputs }:

let
  system = "aarch64-linux";
  hostname = "tartelette";
in {
  nixosConfiguration = flake-inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [ ./system ];

    specialArgs = { inherit username hostname flake-inputs; };
  };

  homeConfiguration = flake-inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = flake-inputs.nixpkgs.legacyPackages.${system};

    modules = [ ./home.nix ];

    extraSpecialArgs = { inherit username flake-inputs; };
  };
}
