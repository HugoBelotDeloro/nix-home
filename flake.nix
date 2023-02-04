{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs }:
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
        imports = [ ./home.nix nix-doom-emacs.hmModule ];
      };

      stateVersion = "21.11";
    };
  };

}
