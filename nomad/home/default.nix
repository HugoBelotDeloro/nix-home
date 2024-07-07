{ config, lib, pkgs, username, flake-inputs, ... }:

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

  nix.registry = {
    nixpkgs.flake = flake-inputs.nixpkgs;
    nixpkgs-unstable.flake = flake-inputs.nixpkgs-unstable;
    nix-home.flake = flake-inputs.self;
  };

  imports = with flake-inputs.self.hmModules; [
    # emacs # see nix-doom-emacs below
    gammastep
    graphicalEnvironment.module
    k8s
    minecraft
    terminalEnvironment.module
    vscode
    # flake-inputs.nix-doom-emacs.hmModule # project currently broken
    ./virtualisation.nix
  ];

  # My usual packages
  home.packages = with pkgs; [

    # Command-line tools
    openssl

    # Administration
    libnotify
    pciutils
    cryptsetup
    rpi-imager
    dmidecode
    nvtopPackages.full

    # Graphical tools
    thunderbird
    libreoffice
    gimp
    calibre
    google-chrome
    discord

    # Software
    texlive.combined.scheme-basic
  ] ++ (with flake-inputs.self.outputs.packages.x86_64-linux; [ pipewire-switch-sink ]);
}
