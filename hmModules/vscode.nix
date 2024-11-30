{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = true;

    extensions = with pkgs.vscode-extensions; [
      bungcip.better-toml
      eamodio.gitlens
      rust-lang.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
      usernamehw.errorlens
      vadimcn.vscode-lldb
    ];
  };
}
