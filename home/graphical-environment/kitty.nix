{ pkgs, ... }:

{
  home.file.kitty = {
    source = ./kitty.conf;
    target = ".config/kitty/kitty.conf";
  };

  home.packages = with pkgs; [
    kitty
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    victor-mono
  ];
}
