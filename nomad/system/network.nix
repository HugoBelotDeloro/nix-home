{ hostname, ... }:
{
  networking = {
    hostName = hostname;

    nameservers = [
      "127.0.0.1"
      "::1"
    ];

    networkmanager = {
      enable = true;
      dns = "none";
    };

    extraHosts = "127.0.0.1 home";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  services.dnscrypt-proxy2 = {
    enable = true;

    settings = {
      require_dnssec = true;
      ipv6_servers = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      server_names = [
        "cloudflare"
        "quad9-doh-ip4-port443-filter-pri"
      ];

      cloaking_rules = "/etc/nixos/cloaking_rules.txt";
      forwarding_rules = "/etc/nixos/forwarding_rules.txt";
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
