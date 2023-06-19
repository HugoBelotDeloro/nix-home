{ config, lib, hostname, ... }:

let
  cfg = config.iridescent.services.syncthing;

  folderConfigType = lib.types.attrsOf (lib.types.submodule ({ name, ... }: {
    options = {
      path = lib.mkOption {
        type = lib.types.str // {
          check = x: lib.types.str.check x && (lib.substring 0 1 x == "/" || lib.substring 0 2 x == "~/");
          description = lib.types.str.description + " starting with / or ~/";
        };
        default = name;
        description = lib.mdDoc ''
          The path to the folder which should be shared.
          Only absolute paths (starting with `/`) and paths relative to
          the [user](#opt-services.syncthing.user)'s home directory
          (starting with `~/`) are allowed.
        '';
      };

      versioning = lib.mkOption {
        default = null;
        description = lib.mdDoc ''
          How to keep changed/deleted files with Syncthing.
          There are 4 different types of versioning with different parameters.
          See <https://docs.syncthing.net/users/versioning.html>.
        '';
        example = lib.literalExpression ''
          [
            {
              versioning = {
                type = "simple";
                params.keep = "10";
              };
            }
            {
              versioning = {
                type = "trashcan";
                params.cleanoutDays = "1000";
              };
            }
            {
              versioning = {
                type = "staggered";
                fsPath = "/syncthing/backup";
                params = {
                  cleanInterval = "3600";
                  maxAge = "31536000";
                };
              };
            }
            {
              versioning = {
                type = "external";
                params.versionsPath = pkgs.writers.writeBash "backup" '''
                  folderpath="$1"
                  filepath="$2"
                  rm -rf "$folderpath/$filepath"
                ''';
              };
            }
          ]
        '';
        type = with lib.types; nullOr (submodule {
          options = {
            type = lib.mkOption {
              type = enum [ "external" "simple" "staggered" "trashcan" ];
              description = lib.mdDoc ''
                The type of versioning.
                See <https://docs.syncthing.net/users/versioning.html>.
              '';
            };
            fsPath = lib.mkOption {
              default = "";
              type = either str path;
              description = lib.mdDoc ''
                Path to the versioning folder.
                See <https://docs.syncthing.net/users/versioning.html>.
              '';
            };
            params = lib.mkOption {
              type = attrsOf (either str path);
              description = lib.mdDoc ''
                The parameters for versioning. Structure depends on
                [versioning.type](#opt-services.syncthing.folders._name_.versioning.type).
                See <https://docs.syncthing.net/users/versioning.html>.
              '';
            };
          };
        });
      };

      rescanInterval = lib.mkOption {
        type = lib.types.int;
        default = 3600;
        description = lib.mdDoc ''
          How often the folder should be rescanned for changes.
        '';
      };

      type = lib.mkOption {
        type = lib.types.enum [ "sendreceive" "sendonly" "receiveonly" "receiveencrypted" ];
        default = "sendreceive";
        description = lib.mdDoc ''
          Whether to only send changes for this folder, only receive them
          or both. `receiveencrypted` can be used for untrusted devices. See
          <https://docs.syncthing.net/users/untrusted.html> for reference.
        '';
      };

      watchDelay = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = lib.mdDoc ''
          The delay (in seconds) after an inotify event is triggered.
        '';
      };
    };
  }));

in
{
  options.iridescent.services.syncthing = {

    enable = lib.mkEnableOption "syncthing custom module";

    devices = lib.mkOption {
      default = {};
      description = ''
      The configuration of the devices and folders for each machine.
      '';
      type = lib.types.attrsOf (lib.types.submodule ({ deviceName, ... }: {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            default = deviceName;
            description = "The name of the device";
          };

          id = lib.mkOption {
            type = lib.types.str;
            description = "The device's ID.";
          };

          folders = lib.mkOption {
            type = folderConfigType;
            default = {};
            description = "The configuration of each folder that should be shared with that machine";
          };
        };
      }));
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "syncthing";
      description = "The user to run Syncthing as.";
    };

    remoteAccess = lib.mkEnableOption "remote access to the control panel";
  };

  config.services.syncthing = lib.mkIf cfg.enable (let

    # Get the list of all devices declaring folder `folderName`
    folderDevices = folderName:
      builtins.filter (value: value != null)
        (lib.mapAttrsToList (deviceName: hasFolder: if hasFolder then deviceName else null)
          (builtins.mapAttrs
            (deviceName: deviceConfig: (builtins.hasAttr folderName deviceConfig.folders))
            cfg.devices
          )
        );

  in {
    enable = true;
    openDefaultPorts = true;

    dataDir = lib.mkIf (cfg.user != "syncthing") "/home/${cfg.user}";

    user = cfg.user;
    group = lib.mkIf (cfg.user != "syncthing") "users";

    guiAddress = if cfg.remoteAccess then "0.0.0.0:8384" else "localhost:8384";

    devices = builtins.mapAttrs (deviceName: deviceConfig: { inherit (deviceConfig) id; }) cfg.devices;
    folders = builtins.mapAttrs
      (folderName: folderConfig: folderConfig // { devices = folderDevices folderName; } )
      cfg.devices.${hostname}.folders;

    overrideDevices = true;
    overrideFolders = true;

    extraOptions = {
      gui = {
        value = {
          user = lib.mkIf cfg.remoteAccess "hugobd";
          password = lib.mkIf cfg.remoteAccess "$2a$10$ZKhH1.a..GHsSeP51T3a.eC9zrgF0NnfgqgyXwiqs8yq.N05BLjbS";
        };
        tls = true;
      };
      options = {
        announceLANAddresses = false; # Only use local network
        relaysEnabled = false; # No relays
        urAccepted = -1; # No Usage Reporting
      };
    };
  });
  config.networking.firewall.allowedTCPPorts = lib.mkIf (cfg.enable && cfg.remoteAccess) [ 8384 ];
}
