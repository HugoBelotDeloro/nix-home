{ pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";
    size = 32;
  };

  home.packages = [ pkgs.kdePackages.breeze ];
}
