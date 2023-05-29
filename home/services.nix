{ config, lib, pkgs, ... }:

{
  services.blueman-applet.enable = true;

  services.syncthing = {
    enable = true;
    tray = { enable = true; };
  };
}
