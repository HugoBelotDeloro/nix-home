{
  description = "A simple flake template";

  outputs = { self, nixpkgs, ... }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      buildInputs = with pkgs; [ ];
    in {
      devShells.${system}.default = pkgs.mkShell { inherit buildInputs; };

      formatter.${system} = pkgs.nixfmt;
    };
}
