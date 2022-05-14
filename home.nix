{ config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hugo";
  home.homeDirectory = "/home/hugo";
  home.sessionVariables = {
    EDITOR = "kak";
    BROWSER = "firefox";
  };

  imports = [
    ./i3.nix
    ./i3status.nix
    ./fish/fish.nix
    ./dunst.nix
    ./kakoune.nix
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
  };

  nixpkgs.config.allowUnfree = true;

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

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;

    status = {
      disabled = false;
    };
  };

  programs.emacs.enable = true;

  xsession.enable = true;
  xsession.pointerCursor.package = pkgs.breeze-qt5;
  xsession.pointerCursor.name = "breeze_cursors";
  xsession.pointerCursor.size = 24;

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
    fish
    kitty
    git
    kakoune
    rofi
    ripgrep
    fd
    (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono"]; })
    emacs-all-the-icons-fonts
    texlive.combined.scheme-basic

    discord
    keepassxc

    jetbrains.webstorm

    pcmanfm
    networkmanagerapplet
    pavucontrol
    pamixer
    libnotify
    lxappearance
    arandr
    breeze-qt5

    tela-icon-theme
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
