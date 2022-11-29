{ config, lib, pkgs, extraPackages, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "kak";
      BROWSER = "firefox";
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

  programs.git = {
    enable = true;
    userEmail = "hugo.belot-deloro@epita.fr";
    userName = "Hugo Belot-Deloro";

    aliases = {
      graph = "log --all --oneline --graph --decorate";
    };
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

  xsession.enable = true;

  gtk.enable = true;
  gtk.theme.package = pkgs.gnome.gnome-themes-extra;
  gtk.theme.name = "Adwaita-dark";
  gtk.iconTheme.name = "Tela"; # Worth trying: "Papirus-Adapta-Nokto-Maia" "Arc" "Pop"

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -c 000000";
  };

  # My usual packages
  home.packages = with pkgs; [

    # Command-line tools
    fish
    kitty
    git
    rofi
    ripgrep
    fd
    jq
    bc
    entr
    zip
    unzip
    neofetch

    # Graphics
    nitrogen
    (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono"]; })
    victor-mono
    emacs-all-the-icons-fonts
    texlive.combined.scheme-basic
    breeze-qt5
    tela-icon-theme

    # Graphical tools
    keepassxc
    pcmanfm
    networkmanagerapplet
    pavucontrol
    pamixer
    libnotify
    lxappearance
    arandr
    gimp
  ] ++ (extraPackages pkgs);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
