function nix-shell-init --description 'Creates basic shell.nix and .envrc'
  echo "\
  { pkgs ? import <nixpkgs> {} }:

  pkgs.mkShell {
    packages = with pkgs; [
    ];
  }" > shell.nix
  echo 'use_nix' >> .envrc
end
