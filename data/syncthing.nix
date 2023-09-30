username: {
  "framework-nixos" = {
    id = "XIQYERO-26LTWQK-WPBCUPF-AZCHTK3-3PYTFCI-BRTEOXG-6UV3GM6-AF23PA6";

    folders = let
      folderDefaultConfig = {
        watchDelay = 3600;
        versioning = {
          type = "simple";
          params.keep = "5";
        };
        rescanInterval = 3600;
      };
    in builtins.mapAttrs
    (_deviceName: deviceConfig: folderDefaultConfig // deviceConfig) {
      "Perso" = {
        path = "/home/${username}/Documents/Perso";
        watchDelay = 60;
      };
      "Shared".path = "/home/${username}/Shared";
      "Pictures".path = "/home/${username}/Pictures";
      "Videos".path = "/home/${username}/Videos";
      "Music".path = "/home/${username}/Music";
    };
  };

  "tartelette" = {
    id = "P3XFVIV-JEJHOZ3-SLL767M-CXJT6RX-6WF6YSY-5ILHHZX-SFCOYP5-R2M3RAA";

    folders = let
      folderDefaultConfig = {
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
    in builtins.mapAttrs
    (_deviceName: deviceConfig: folderDefaultConfig // deviceConfig) {
      "Perso".path = "/home/hugobd/syncthing/Perso";
      "Shared".path = "/home/hugobd/syncthing/Shared";
    };
  };

  "xiao" = {
    id = "ZURVJF5-B2RXMSS-TAPOUCN-PM7CQAR-Y2HZUMG-5WV6EZM-RFYAILK-WSGLSQ2";

    folders = {
      "Perso" = { };
      "Shared"= { };
      "Pictures"= { };
      "Videos"= { };
      "Music"= { };
    };
  };
}
