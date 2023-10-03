{ username, flake-inputs }:

let
  system = "aarch64-linux";
  hostname = "tartelette";

  modules = [
    ./system
    flake-inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = ./home.nix;
      home-manager.extraSpecialArgs = { inherit username flake-inputs; };
    }
  ];

  specialArgs = { inherit username hostname flake-inputs; };

  nixosConfigurationParameters = {
    inherit system modules specialArgs;
  };

in {
  nixosConfiguration = flake-inputs.nixpkgs.lib.nixosSystem nixosConfigurationParameters;

  nixosSDImage = flake-inputs.nixos-generators.nixosGenerate {
    inherit system specialArgs;

    format = "sd-aarch64";

    modules = modules ++ [{ sdImage.compressImage = false; }];
  };
}
