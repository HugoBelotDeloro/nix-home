{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    localConfig = import ./local-configs/framework.nix;
    username = localConfig.username;

  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs system username;

      homeDirectory = "/home/${username}";

      extraSpecialArgs = {
        extraPackages = localConfig.extraPackages;
      };

      configuration = {
        imports = [ ./home.nix ];
      };

      stateVersion = "21.11";
    };
  };

}
