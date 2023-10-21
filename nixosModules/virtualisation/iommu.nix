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

    passthrough = mkEnableOption "IOMMU passthrough";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "${cfg.cpu_type}_iommu=on" ]
      ++ optionals cfg.passthrough [ "iommu=pt" ];
  };
}
