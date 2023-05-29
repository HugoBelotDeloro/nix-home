{ config, lib, pkgs, ... }:

let
  username = "hugobd";
  homeDirectory = "/home/${username}";
in {
  home = {
    inherit username homeDirectory;
    stateVersion = "21.11";

    sessionVariables = {
      BROWSER = "firefox";
    };

    sessionPath = [ "~/.emacs.d/bin" "~/bin" ];
  };

  imports = [
    ./fish/fish.nix
    ./services.nix
    ./gammastep.nix
    ./emacs.nix
    ./vscode.nix
    (import ./graphical-environment).module
    (import ./terminal-environment).module
  ];

  home.file = {
    fish_functions = {
      source = ./fish/functions;
      target = ".config/fish/functions";
      recursive = true;
    };

    flake_base = {
      source = ../resources/flake-example.nix;
      target = "home-resources/flake-example.nix";
    };
  };

  # See https://github.com/nix-community/home-manager/issues/2942
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.emacs.enable = true;

  # My usual packages
  home.packages = with pkgs; [

    # Command-line tools
    xsel
    openssl
    k9s
    kubectl

    # Looks
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
    emacs-all-the-icons-fonts

    # Administration
    nitrogen
    networkmanagerapplet
    pavucontrol
    pamixer
    libnotify
    lxappearance
    arandr
    gammastep
    pciutils
    gparted
    cryptsetup

    # Graphical tools
    google-chrome

    # Software
    texlive.combined.scheme-basic
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
