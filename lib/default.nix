flake-inputs: {
  templating = (import ./templating.nix) flake-inputs;

  forAllSystems =
    supportedSystems: f:
    flake-inputs.nixpkgs.lib.genAttrs supportedSystems (
      system:
      f {
        inherit system;
        pkgs = flake-inputs.nixpkgs.legacyPackages.${system};
      }
    );
}
