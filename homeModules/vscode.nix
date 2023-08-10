{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    mutableExtensionsDir = true;

    extensions = with pkgs.vscode-extensions; [
      bungcip.better-toml
      eamodio.gitlens
      matklad.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
      usernamehw.errorlens
      vadimcn.vscode-lldb
    ];
  };
}
