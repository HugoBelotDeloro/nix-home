{
  description = "A simple flake template";

  outputs = { self, nixpkgs, ... }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      python = pkgs.python3;
      python-packages = (python-pkgs: with python-pkgs; [
      ]);
      buildInputs = with pkgs; [ ];

    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ (python.withPackages python-packages) ];
        inherit buildInputs;
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
