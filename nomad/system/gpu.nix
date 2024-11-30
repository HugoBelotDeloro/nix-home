# AMD RX6700 XT Sapphire Pulse
{ flake-inputs, ... }:

{
  services.xserver.videoDrivers = [
    # X server fails to start if amdgpu is loaded
    #"amdgpu"

    # Default values (tried in order)
    "modesetting"
    "fbdev"
  ];

  boot.kernelModules = [ "amdgpu" ];

  hardware.graphics = {
    enable = true; # Mesa
    enable32Bit = true;
  };
}
