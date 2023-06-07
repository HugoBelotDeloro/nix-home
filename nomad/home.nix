{ config, lib, pkgs, homeModules, ... }:

let
  username = "hugobd";
  homeDirectory = "/home/${username}";
in {
  home = {
    inherit username homeDirectory;
    stateVersion = "21.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # See https://github.com/nix-community/home-manager/issues/2942
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  imports = with homeModules; [
    ../home/emacs
    ../home/gammastep.nix
    (import ../home/graphical-environment).module
    (import ../home/terminal-environment).module
    ../home/vscode.nix
  ];

  home.file.flake_base = {
    source = ../resources/flake-example.nix;
    target = "home-resources/flake-example.nix";
  };

  # My usual packages
  home.packages = with pkgs; [

    # Command-line tools
    openssl
    k9s
    kubectl

    # Administration
    libnotify
    pciutils
    cryptsetup

    # Graphical tools
    google-chrome

    # Software
    texlive.combined.scheme-basic
  ];
}
