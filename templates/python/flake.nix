{
  description = "A simple flake template";

  inputs.poetry2nix.url = "github:nix-community/poetry2nix";

  outputs = { self, nixpkgs, poetry2nix, ... }:

    let
      name = "replace_me";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; })
        mkPoetryApplication;
      app = mkPoetryApplication { projectDir = ./.; };

    in {
      inherit name;

      packages.${system} = {
        default = mkPoetryApplication { projectDir = self; };
        ${self.name} = self.packages.${system}.default;
      };

      app.${system}.default = {
        type = "app";
        program = "${self.packages.default}/bin/${self.name}";
      };

      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ self.packages.${system}.default ];
        packages = with pkgs; [ pyright ruff poetry ];
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
