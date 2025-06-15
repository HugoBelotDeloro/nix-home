{
  services.k3s = {
    enable = true;
    role = "server"; # Configure to allow agent
    #serverAddr = "https://10.0.0.1:6443";
    tokenFile = "/state/k3s/token"; # Will need to create the token
    #configPath = "/state/k3s/config.yml";
    gracefulNodeShutdown.enable = true;
    extraFlags = [
      # I would like to change the data dir but the location is hardcoded in the module.
      #"--data-dir /state/k3s/data"
      #"--disable metrics-server"
    ];
  };
  networking = {
    firewall.allowedTCPPorts = [ 6443 ];
    firewall.trustedInterfaces = [ "cni+" ];
  };

  boot.kernelModules = [ "br_netfilter" "ip_conntrack" "ip_vs" "ip_vs_rr" "ip_vs_wrr" "ip_vs_sh" "overlay" ];
}
