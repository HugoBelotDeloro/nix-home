{ config, pkgs, lib, hostname, username, ... }:

let
  devices = {
    framework-nixos.id = "XIQYERO-26LTWQK-WPBCUPF-AZCHTK3-3PYTFCI-BRTEOXG-6UV3GM6-AF23PA6";
    tartelette.id = "P3XFVIV-JEJHOZ3-SLL767M-CXJT6RX-6WF6YSY-5ILHHZX-SFCOYP5-R2M3RAA";
    asus.id = "ZCKMKCR-OLUKBI6-AHSYE4X-JBXGWPX-6B76U4Y-CLEUU3Q-OITQYHB-EF252AT";
  };

  folders = hostname: builtins.mapAttrs
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
        versioning = {
          type = "simple";
          params.keep = "10";
        };
      };

      "Shared" = {
        devices = [
          "framework-nixos"
          "asus"
        ];
        path = "/home/${username}/Shared";
        versioning = {
          type = "simple";
          params.keep = "10";
        };
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
    guiAddress = "localhost:8384";

    folders = folders hostname;
    inherit devices;

    overrideDevices = true;
    overrideFolders = true;

    extraOptions = {
      gui = {
        value = {
          user = "hugobd";
          password = "$2a$10$ZKhH1.a..GHsSeP51T3a.eC9zrgF0NnfgqgyXwiqs8yq.N05BLjbS";
        };
        tls = true;
      };
      options = {
        announceLANAddresses = false; # Only use local network
        relaysEnabled = false; # No relays
        urAccepted = -1; # No Usage Reporting
      };
    };
  };
}
