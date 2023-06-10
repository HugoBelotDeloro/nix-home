{
  nixpkgs,
  nixos-hardware,
  home-manager,
  nixosModules,
  homeModules,
  username
}:

let
  system = "aarch64-linux"
  hostname = "tartelette";
in
{
  nixosConfiguration = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./system
      nixos-hardware.nixosModules."raspberry-pi-4"
    ];

    specialArgs = {
      inherit username hostname;
    };
  };

  homeConfiguration = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};

    modules = [
      ./home.nix
      homeModules.nix-doom-emacs
    ];

    extraSpecialArgs = {
      inherit homeModules username;
    };
  };
}
