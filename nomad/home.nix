{ config, lib, pkgs, homeModules, username, flake-inputs, ... }:

let homeDirectory = "/home/${username}";
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

  nix.registry.nixpkgs.flake = flake-inputs.nixpkgs;
  nix.registry.nixpkgs-unstable.flake = flake-inputs.nixpkgs-unstable;

  imports = with homeModules; [
    emacs
    gammastep
    graphicalEnvironment
    terminalEnvironment
    vscode
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
    rpi-imager

    # Graphical tools
    thunderbird
    libreoffice
    gimp
    calibre
    google-chrome
    discord
    logseq

    # Software
    texlive.combined.scheme-basic
  ];
}
