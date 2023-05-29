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
    ./services.nix
    ./gammastep.nix
    ./emacs.nix
    ./vscode.nix
    (import ./graphical-environment).module
    (import ./terminal-environment).module
  ];

  home.file.flake_base = {
    source = ../resources/flake-example.nix;
    target = "home-resources/flake-example.nix";
  };

  # See https://github.com/nix-community/home-manager/issues/2942
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.emacs.enable = true;

  # My usual packages
  home.packages = with pkgs; [

    # Command-line tools
    openssl
    k9s
    kubectl

    # Looks
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
    emacs-all-the-icons-fonts

    # Administration
    libnotify
    gammastep
    pciutils
    cryptsetup

    # Graphical tools
    google-chrome

    # Software
    texlive.combined.scheme-basic
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
