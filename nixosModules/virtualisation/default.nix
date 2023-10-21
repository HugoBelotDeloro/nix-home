let
  iommu = import ./iommu.nix;
  vfio = import ./vfio.nix;
  module = { imports = [ iommu vfio ]; };
in { inherit iommu vfio module; }
