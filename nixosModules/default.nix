{
  display-manager = import ./display-manager.nix;
  dnscrypt-proxy2 = import ./dnscrypt-proxy2.nix;
  minecraft-unit = import ./minecraft-unit.nix;
  openssh = import ./openssh.nix;
  syncthing = import ./syncthing.nix;
  virtualisation = import ./virtualisation;
  vm = import ./vm.nix;
}
