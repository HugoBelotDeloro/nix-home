{ config, pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--disable metrics-server";
  };

  networking.firewall.allowedTCPPorts= [ 6443 ];
}
