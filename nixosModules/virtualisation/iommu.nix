{ pkgs, config, lib, ... }:
with lib;
let cfg = config.virtualisation.iommu;
in {
  options.virtualisation.iommu = {
    enable = mkEnableOption "IOMMU";

    cpu_type = mkOption {
      type = types.enum [ "intel" "amd" ];
      description = "The CPU vendor";
      example = "intel";
    };
  };

  config = mkIf cfg.enable {
    assertions = [ ];

    boot.kernelParams = [ "${cfg.cpu_type}_iommu=on" ];
  };
}

# TODO iommu=pt
