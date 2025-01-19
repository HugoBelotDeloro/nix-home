{ pkgs, username, ... }:
{

  programs.ripgrep = {
    enable = true;
    arguments = [ "--smart-case" ];
  };
}
