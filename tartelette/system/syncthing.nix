{ username, flake-inputs, ... }:

{
  config.iridescent.services.syncthing = {
    enable = true;
    remoteAccess = true;
    user = username;
    devices = flake-inputs.self.data.syncthingDevices username;
  };
}
