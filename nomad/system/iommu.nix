{ flake-inputs, ... }:

{
  imports = [ flake-inputs.self.nixosModules.virtualisation.iommu ];

  virtualisation.iommu = {
    enable = true;
    cpu_type = "intel";
  };
}
