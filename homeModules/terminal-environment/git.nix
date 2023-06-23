{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "hugo.belot-deloro@epita.fr";
    userName = "Hugo Belot-Deloro";

    aliases = { graph = "log --all --oneline --graph --decorate"; };

    delta.enable = true;
    delta.options = let
      green = "#2c3c2c";
      bright-green = "#2c6c2c";
      red = "#3c2c2c";
      bright-red = "#6c2c2c";
    in {
      side-by-side = true;
      keep-plus-minus-markers = false;

      plus-emph-style = "#ffffff ${bright-green}";
      plus-non-emph-style = "syntax ${green}";
      plus-style = "syntax ${bright-green}";

      minus-emph-style = "#ffffff ${bright-red}";
      minus-non-emph-style = "syntax ${red}";
      minus-style = "syntax ${bright-red}";
    };
  };
}
