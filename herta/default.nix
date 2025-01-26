{
  flake-inputs,
  username ? "admin",
  hostname ? "nixos-vm",
}:

let
  nixosSystem = flake-inputs.nixpkgs.lib.nixosSystem;
in
nixosSystem {
  system = "x86_64-linux";

  modules = [
    flake-inputs.self.nixosModules.vm
    ({ config, ... }: {
      microvm = {
        hypervisor = "cloud-hypervisor";

        shares = [
          {
            proto = "virtiofs";
            tag = "ro-store";
            source = "/nix/store";
            mountPoint = "/nix/.ro-store";
          }
          {
            proto = "virtiofs";
            tag = "test";
            source = "/home/hugobd/nix-home/virtiofstest";
            mountPoint = "/state";
          }
        ];

        writableStoreOverlay = "/nix/.rw-store";
        volumes = [
          {
            image = "rw-store-overlay.img";
            label = "rw-store-overlay";
            mountPoint = config.microvm.writableStoreOverlay;
            size = 2048;
          }
        ];
      };
    })
  ];

  specialArgs = { inherit username hostname flake-inputs; };
}
