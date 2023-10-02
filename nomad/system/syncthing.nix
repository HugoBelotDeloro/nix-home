{ username, flake-inputs, ... }:

{
  imports = [ flake-inputs.self.nixosModules.syncthing ];

  config.iridescent.services.syncthing = {
    enable = true;
    remoteAccess = false;
    user = username;
    devices = flake-inputs.self.data.syncthingDevices username;
  };
}
