{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "Monokai";
  };

  home.packages = [ pkgs.rofi ];
}
