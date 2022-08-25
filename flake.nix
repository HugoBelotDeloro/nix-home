{
  description = "Home Manager configuration of Hugo Belot-Deloro";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.hugobd = home-manager.lib.homeManagerConfiguration {
        inherit pkgs system;

        configuration = {
          imports = [ ./home.nix ];
        };
        homeDirectory = "/home/hugobd";
        username = "hugobd";

        stateVersion = "21.11";

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        # modules = [
        #   ./home.nix
        # ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
