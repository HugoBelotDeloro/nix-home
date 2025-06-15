{ pkgs, ... }:

{
  home.file.kitty = {
    source = ./kitty.conf;
    target = ".config/kitty/kitty.conf";
  };

  home.packages = with pkgs; [
    kitty
    nerd-fonts.fira-code
    victor-mono
  ];
}
