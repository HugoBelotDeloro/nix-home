{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.jetbrains-mono ];
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom-emacs;
  };
}
