{ flake-inputs, ... }:

{
  imports = [ flake-inputs.self.nixosModules.virtualisation.vfio ];

  virtualisation.vfio.enable = true;
  virtualisation.vfio.devices = [ "1002:73df" "1002:ab28" ];
}
