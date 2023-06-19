{ username, data, ... }:

{
  config.iridescent.services.syncthing = {
    enable = true;
    remoteAccess = true;
    user = username;
    devices = data.syncthingDevices username;
  };
}
