{
  default = {
    path = ./default;
    description = (import ./default/flake.nix).description;
  };

  rust = {
    path = ./rust;
    description = (import ./rust/flake.nix).description;
  };

  python = {
    path = ./python;
    description = (import ./python/flake.nix).description;
  };
}
