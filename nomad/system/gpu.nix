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

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.opengl = {
    enable = true; # Mesa
    driSupport = true;
    driSupport32Bit = true;
  };
}
