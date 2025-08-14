{
  hostname,
  lib,
  flake-inputs,
  ...
}:

{
  imports = [ flake-inputs.self.nixosModules.dnscrypt-proxy2 ];

  networking = {
    hostName = hostname;

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;

    networkmanager = {
      enable = true;
      dns = lib.mkForce "none";
    };
    useNetworkd = true;

    dhcpcd.enable = false;

    firewall.enable = true;
  };
}
