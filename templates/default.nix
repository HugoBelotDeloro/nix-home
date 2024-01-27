{
  default = {
    path = ./default;
    description = (import ./default/flake.nix).description;
  };

  rust = {
    path = ./rust;
    description = (import ./rust/flake.nix).descrition;
  };
}
