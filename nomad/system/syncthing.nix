{ username, data, ... }:

{
  config.iridescent.services.syncthing = {
    enable = true;
    remoteAccess = false;
    user = username;
    devices = data.syncthingDevices username;
  };
}
