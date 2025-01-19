{
  config,
  lib,
  pkgs,
  ...
}:

{
  containers = {
    k3s = {

      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.11";
      privateNetwork = true;

      config = import ./k3s.nix;
    };
  };
}
