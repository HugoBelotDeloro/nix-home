{ username, flake-inputs }:

let
  system = "aarch64-linux";
  hostname = "tartelette";

  nixosConfigurationParameters = {
    inherit system;

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
  };

in {
  nixosConfiguration = flake-inputs.nixpkgs.lib.nixosSystem nixosConfigurationParameters;

  nixosSDImage = flake-inputs.nixos-generators.nixosGenerate (nixosConfigurationParameters // {
    format = "sd-aarch64";
    modules = [{
      # At time of writing, the zfs-kernel package is broken which prevents building.
      # Somehow removing compression avoids the need for zfs.
      sdImage.compressImage = false;
    }];
  });
}
