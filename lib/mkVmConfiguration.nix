{
  system,
  username ? "admin",
  hostname ? "nixos-vm",
  cpuCores ? 1,
  memorySizeGb ? 1,
  sshHostPort ? null,
  flake-inputs,
}:

{
  inherit system;

  modules = [
    flake-inputs.self.nixosModules.vm
    {
      virtualisation = {
        cores = cpuCores;
        memorySize = 1024 * memorySizeGb;

        forwardPorts = if sshHostPort != null then [{
          from = "host";
          host.port = sshHostPort;
          guest.port = 22;
        }] else [];
      };
    }
  ];

  specialArgs = { inherit username hostname flake-inputs; };
}
