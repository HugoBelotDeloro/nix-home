{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    mutableExtensionsDir = true;

    extensions = with pkgs.vscode-extensions; [
      bungcip.better-toml
      eamodio.gitlens
      ms-vscode-remote.remote-ssh
      matklad.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
      usernamehw.errorlens
      zxh404.vscode-proto3
      github.vscode-pull-request-github
      vadimcn.vscode-lldb
    ];
  };
}
