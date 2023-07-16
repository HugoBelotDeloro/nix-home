{
  syncthingDevices = import ./syncthing.nix;
  sshKeys = import ./ssh-keys.nix;
  sshHosts = import ./ssh-hosts.nix;
}
