{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.gammastep ];

  services.gammastep = {
    enable = true;
    tray = true;

    dawnTime = "6:00-8:00";
    duskTime = "20:00-22:00";
    provider = "manual";
    settings = {
      general = {
        adjustment-method = "randr";
      };
    };
    temperature.day = 6500;
    temperature.night = 2000;
  };
}
