{ config, pkgs, lib, hostname, username, ... }:

let
  devices = {
    framework-nixos.id = "XIQYERO-26LTWQK-WPBCUPF-AZCHTK3-3PYTFCI-BRTEOXG-6UV3GM6-AF23PA6";
    asus.id = "ZCKMKCR-OLUKBI6-AHSYE4X-JBXGWPX-6B76U4Y-CLEUU3Q-OITQYHB-EF252AT";
  };

  folders = hostname: lib.mapAttrs
    (n: v: {
      # Only enable if current host uses device
      enable = builtins.elem hostname v.devices;
    } // v) {

      "Perso" = {
        devices = [
          "framework-nixos"
          "asus"
        ];
        path = "/home/${username}/Documents/Perso";
      };

      "Shared" = {
        devices = [
          "framework-nixos"
          "asus"
        ];
        path = "/home/${username}/Shared";
      };

    };
in
{
  services.syncthing = {
    enable = true;
    dataDir = "/home/${username}/";
    openDefaultPorts = true;
    configDir = "/home/${username}/.config/syncthing";
    user = username;
    group = "users";
    guiAddress = "127.0.0.1:8384";

    folders = folders hostname;
    inherit devices;

    overrideDevices = true;
    overrideFolders = true;
  };
}
