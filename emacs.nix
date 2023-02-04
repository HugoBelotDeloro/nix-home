{ config, lib, pkgs, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom-emacs;
  };
}
