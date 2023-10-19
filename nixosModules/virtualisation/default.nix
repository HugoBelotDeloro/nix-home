let
  iommu = import ./iommu.nix;
  module = { imports = [ iommu ]; };
in { inherit iommu module; }
