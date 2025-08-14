flake-inputs:
let
  inherit (flake-inputs.self.lib.templating) templatifyRecursive symlinkTreeToRegularFiles;
  data = flake-inputs.self.data.me;

  mkFlakeTemplate =
    path:
    let
      symlinkedTemplate = templatifyRecursive { inherit path data; };
      regularFiles = symlinkTreeToRegularFiles (symlinkedTemplate);
    in
    "${regularFiles}";

in
{
  default = {
    path = mkFlakeTemplate ./default;
    description = (import ./default/flake.nix).description;
  };

  rust = {
    path = mkFlakeTemplate ./rust;
    description = (import ./rust/flake.nix).description;
  };

  python = {
    path = mkFlakeTemplate ./python;
    description = (import ./python/flake.nix).description;
  };
}
