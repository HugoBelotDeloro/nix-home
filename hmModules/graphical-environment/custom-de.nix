# In case I want to use i3 without KDE Plasma
{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.gammastep ];

  services.dunst.enable = true;
  services.clipcat.enable = true;

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -c 000000";
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  xsession.windowManager.i3.config.startup = [{
    command = "${pkgs.pasystray}/bin/pasystray --volume-max=100 --volume-inc=1 --notify=all";
    notification = false;
  }];
}
