{ config, pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--disable metrics-server";
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 6443 ];

  system.stateVersion = "22.11";
}
