{ config, lib, pkgs, extraPackages, ... }:

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
    ./i3.nix
    ./i3status.nix
    ./fish/fish.nix
    ./dunst.nix
    ./kakoune.nix
    ./services.nix
    ./gammastep.nix
    ./emacs.nix
    ./vscode.nix
    ./git.nix
  ];

  home.file = {
    kitty = {
      source = ./kitty.conf;
      target = ".config/kitty/kitty.conf";
    };

    fish_functions = {
      source = ./fish/functions;
      target = ".config/fish/functions";
      recursive = true;
    };

    flake_base = {
      source = ./resources/flake-example.nix;
      target = "home-resources/flake-example.nix";
    };
  };

  home.pointerCursor = {
    package = pkgs.breeze-qt5;
    name = "breeze_cursors";
    size = 24;
  };

  # See https://github.com/nix-community/home-manager/issues/2942
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  fonts.fontconfig.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.exa.enable = true;

  programs.bat = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
    theme = "Monokai";
  };

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;

    status = {
      disabled = false;
    };
  };

  programs.emacs.enable = true;

  programs.autorandr.enable = true;

  xsession.enable = true;

  gtk.enable = true;
  gtk.theme.package = pkgs.gnome.gnome-themes-extra;
  gtk.theme.name = "Adwaita-dark";
  gtk.iconTheme.name = "Tela"; # Worth trying: "Papirus-Adapta-Nokto-Maia" "Arc" "Pop"

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -c 000000";
  };

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
    (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono"]; })
    victor-mono
    emacs-all-the-icons-fonts
    breeze-qt5
    tela-icon-theme

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
    kitty
    rofi
    keepassxc
    pcmanfm
    firefox
    google-chrome

    # Software
    texlive.combined.scheme-basic
  ] ++ (extraPackages pkgs);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
