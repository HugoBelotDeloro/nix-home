{ config, pkgs, lib, hostname, username, ... }:

let
  devices = builtins.mapAttrs (deviceName: deviceConfig: { inherit (deviceConfig) id; }) cfg;

  folders = builtins.mapAttrs (folderName: folderConfig: folderConfig // { devices = folderDevices folderName; }) cfg.${hostname}.folders;

  # Get the list of all devices declaring folder `folderName`
  folderDevices = folderName:
    builtins.filter (value: value != null)
      (lib.mapAttrsToList (deviceName: hasFolder: if hasFolder then deviceName else null)
        (builtins.mapAttrs
          (deviceName: deviceConfig: (builtins.hasAttr folderName deviceConfig.folders))
          cfg
        )
      );

  cfg = {
      "framework-nixos" = {
        id = "XIQYERO-26LTWQK-WPBCUPF-AZCHTK3-3PYTFCI-BRTEOXG-6UV3GM6-AF23PA6";
        folders = {
          "Perso" = {
            path = "/home/${username}/Documents/Perso";
            watchDelay = 60;
            versioning = {
              type = "simple";
              params.keep = "5";
            };
            rescanInterval = 3600;
          };
          "Shared" = {
            path = "/home/${username}/Shared";
            watchDelay = 3600;
            versioning = {
              type = "simple";
              params.keep = "5";
            };
            rescanInterval = 3600;
          };
        };
      };

      "tartelette" = {
        id = "P3XFVIV-JEJHOZ3-SLL767M-CXJT6RX-6WF6YSY-5ILHHZX-SFCOYP5-R2M3RAA";
        folders = {
          "Perso" = {
            path = "/var/lib/syncthing/Perso";
            watchDelay = 3600;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "0";
              };
            };
            rescanInterval = 3600;
            type = "receiveonly";
          };
          "Shared" = {
            path = "/var/lib/syncthing/Shared";
            watchDelay = 3600;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "0";
              };
            };
            rescanInterval = 3600;
            type = "receiveonly";
          };
        };
      };

      "asus" = {
        id = "ZCKMKCR-OLUKBI6-AHSYE4X-JBXGWPX-6B76U4Y-CLEUU3Q-OITQYHB-EF252AT";
        folders = {
          "Perso" = {};
          "Shared" = {};
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

    inherit devices folders;

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
