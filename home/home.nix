{ config, lib, pkgs, ... }:

let
  username = "hugobd";
  homeDirectory = "/home/${username}";
in {
  home = {
    inherit username homeDirectory;
    stateVersion = "21.11";

    sessionVariables = {
      EDITOR = "kak";
      BROWSER = "firefox";
      MANPAGER = "sh -c 'col -bx | bat -l man -p --paging always'";
    };

    sessionPath = [ "~/.emacs.d/bin" "~/bin" ];
  };

  imports = [
    ./fish/fish.nix
    ./kakoune.nix
    ./services.nix
    ./gammastep.nix
    ./emacs.nix
    ./vscode.nix
    ./git.nix
    (import ./graphical-environment).module
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.exa.enable = true;

  programs.bat = {
    enable = true;
  };

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;

    status = {
      disabled = false;
    };
  };

  programs.emacs.enable = true;

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'bat -n --color=always --paging=never -r :\\$FZF_PREVIEW_LINES {}'" ];
    defaultOptions = [ "--height 40%" "--min-height 10" ];
  };

  programs.btop.enable = true;

  # My usual packages
  home.packages = with pkgs; [

    # Command-line tools
    fish
    xsel
    ripgrep
    fd
    sd
    jq
    bc
    entr
    zip
    unzip
    neofetch
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
