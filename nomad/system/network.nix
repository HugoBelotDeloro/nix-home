{ hostname, lib, flake-inputs, ... }:

{
  imports = [ flake-inputs.self.nixosModules.dnscrypt-proxy2 ];

  networking = {
    hostName = hostname;

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # interfaces.wlp166s0.useDHCP = lib.mkDefault true;

    networkmanager = {
      enable = true;
      dns = lib.mkForce "none";
      unmanaged = [ "interface-name:vm-tap*" ];
    };
    useNetworkd = true;

    #useDHCP = false;
    dhcpcd.enable = false;

    nat = {
      enable = true;
      internalIPs = ["10.0.0.0/24"];
      externalInterface = "wlp168s0";
    };

    firewall.enable = true;
  };

  systemd.network = {
    enable = true;
    wait-online.enable = false;

    networks = let
      vmCount = 3;
      seq = builtins.genList (i: i + 1) vmCount;
      networks = map (i: { name = "3${toString i}-vm"; value = {
        matchConfig.Name = ["vm-tap*"];
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
