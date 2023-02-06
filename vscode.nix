{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = [
      bungcip.better-toml
      eamodio.gitlens
      ms-vscode-remote.remote-ssh
      matklad.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
      usernamehw.errorlens
      zxh404.vscode-proto3
      github.vscode-pull-request-github
    ];
  };
}
