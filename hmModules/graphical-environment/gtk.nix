{ pkgs, ... }:

{
  gtk.enable = true;
  gtk.theme.package = pkgs.gnome-themes-extra;
  gtk.theme.name = "Adwaita-dark";
  gtk.iconTheme.name =
    #"Tela"
    # Worth trying:
    "Papirus-Adapta-Nokto-Maia"
  #"Arc"
  #"Pop"
  ;

  home.packages = with pkgs; [
    #tela-icon-theme
    papirus-maia-icon-theme
    #arc-icon-theme
    #pop-icon-theme
  ];
}
