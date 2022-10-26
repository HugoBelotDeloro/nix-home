{ config, lib, pkgs, ... }:

{
  services.blueman-applet.enable = true;
  services.flameshot.enable = true;
}
