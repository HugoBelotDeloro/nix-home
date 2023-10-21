{ pkgs, config, lib, ... }:
with lib;
let cfg = config.virtualisation.vfio;
in {
  options.virtualisation.vfio = {
    enable = mkEnableOption "VFIO";

    devices = mkOption {
      type = types.listOf types.str;
      description = "The IDs of the devices to bind VFIO drivers to.";
      example = [ "1002:73df" "1002:ab28" ];
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams =
      [ ("vfio-pci.ids=" + builtins.concatStringsSep "," cfg.devices) ];

    boot.initrd.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" ];
  };
}
