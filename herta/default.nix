{
  flake-inputs,
  index ? 1,
  username ? "admin",
  hostname ? "herta",
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

        # Shared directories
        shares = [
          {
            # Read-only Nix store (reduces the size of the build as no need to copy)
            proto = "virtiofs";
            tag = "ro-store";
            source = "/nix/store";
            mountPoint = "/nix/.ro-store";
          }
          #{
          #  proto = "virtiofs";
          #  tag = "test";
          #  source = "/home/hugobd/nix-home/virtiofstest";
          #  mountPoint = "/state";
          #}
        ];

        # Writable store overlay in case we need additional packages
        writableStoreOverlay = "/nix/.rw-store";
        volumes = [
          {
            image = "rw-store-overlay.img";
            label = "rw-store-overlay";
            mountPoint = config.microvm.writableStoreOverlay;
            size = 2048;
          }
        ];

        interfaces = [{
            type = "tap";
            id = "vm-tap${index}";
            mac = "00:00:00:00:00:0${index}";
        }];
      };

      networking.useNetworkd = true;
      systemd.network.enable = true;
      systemd.network.networks."20-lan" = {
        matchConfig.MACAddress = "00:00:00:00:00:0${index}";
        address = ["10.0.0.${index}/32"];
        routes = [{
          Destination = "10.0.0.0/32";
          GatewayOnLink = true;
        }
        {
          Destination = "0.0.0.0/0";
          Gateway = "10.0.0.0";
          GatewayOnLink = true;
        }
        ];
        networkConfig = {
          # I'd love to change it to 10.0.0.0 (using the host's dnscrypt-proxy2 as nameserver)
          # But systemd-resolved seems to not like that and fails miserably.
          # This might be linked to a very old and unresolved issue
          # (https://github.com/systemd/systemd/issues/13432).
          # If it ever get fixed or I find some time to yeet resolved out of the setup, might be
          # worth trying again.
          # Note: will need this line on host:
          # firewall.interfaces.vm-tap1.allowedTCPPorts = [ 53 ];
          DNS = ["9.9.9.9"];
        };
      };
    })
  ];

  specialArgs = { inherit username hostname flake-inputs; };
}
