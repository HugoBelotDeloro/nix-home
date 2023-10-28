{
  default = {
    path = ./default;
    description = (import ./default/flake.nix).description;
  };
}
