{ flake-inputs, ...}:

{
  imports = [ flake-inputs.microvm.nixosModules.host ];

  networking = {
    networkmanager.unmanaged = [ "interface-name:vm-tap*" ];

    nat = {
      enable = true;
      internalIPs = ["10.0.0.0/24"];
      externalInterface = "wlp168s0";
    };
  };

  systemd.network = {
    enable = true;
    wait-online.enable = false;

    networks = let
      vmCount = 3;
      seq = builtins.genList (i: i + 1) vmCount;
      networks = map (i: { name = "3${toString i}-vm"; value = {
        matchConfig.Name = ["vm-tap${toString i}"];
        address = ["10.0.0.0/32"];
        routes = [{
          Destination = "10.0.0.${toString i}/32";
        }];
        networkConfig = {
          IPv4Forwarding = true;
        };
      }; }) seq;
    in builtins.listToAttrs networks;
  };
}
