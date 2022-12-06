{ config, lib, pkgs, ... }:

{
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    settings = {
      general = {
        adjustment-method = "randr";
      };
    };
  };
}
