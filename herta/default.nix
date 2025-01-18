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
    {
      microvm = {
        hypervisor = "qemu";
        socket = "control.socket";

        interfaces = [{
          type = "user";
          id = "vm-if";
          mac = "02:00:00:00:00:01";
        }];

        shares = [{
          proto = "9p";
          tag = "ro-store";
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
        }];

        forwardPorts =  [{
          from = "host";
          host.port = 2222;
          guest.port = 22;
        }];
      };
      networking.firewall.allowedTCPPorts = [ 22 ];

    }
  ];

  specialArgs = { inherit username hostname flake-inputs; };
}
