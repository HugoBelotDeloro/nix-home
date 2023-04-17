{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/home/hugobd/";
    openDefaultPorts = true;
    configDir = "/home/hugobd/.config/syncthing";
    user = "hugobd";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    devices = {
      asus.id = "ZCKMKCR-OLUKBI6-AHSYE4X-JBXGWPX-6B76U4Y-CLEUU3Q-OITQYHB-EF252AT";
    };
    folders = {
      "Perso" = {
        enable = true;
        devices = [
          "asus"
        ];
        path = "/home/hugobd/Documents/Perso";
      };
      "Shared" = {
        enable = true;
        devices = [
          "asus"
        ];
        path = "/home/hugobd/Shared";
      };
    };
    overrideDevices = true;
    overrideFolders = true;
  };
}
