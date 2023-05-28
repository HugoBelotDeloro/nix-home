{ pkgs, ...}:

{
  home.pointerCursor = {
    package = pkgs.breeze-qt5;
    name = "breeze_cursors";
    size = 24;
  };

  home.packages = [ pkgs.breeze-qt5 ];
}
