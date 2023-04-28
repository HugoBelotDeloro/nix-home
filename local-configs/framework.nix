{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    thunderbird
    libreoffice
    calibre
    jetbrains.idea-ultimate
    jetbrains.webstorm
    gimp

    # Stockly
    _1password-gui
    slack
    rustup
    jetbrains.datagrip
    bloomrpc
  ];
}
