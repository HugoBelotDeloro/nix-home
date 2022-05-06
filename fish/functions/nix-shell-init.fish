function nix-shell-init
  echo "\
  { pkgs ? import <nixpkgs> {} }:

  pkgs.mkShell {
    packages = with pkgs; [
    ];
  }" > shell.nix
  echo 'use_nix' > .envrc
end
