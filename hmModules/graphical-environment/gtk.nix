{ pkgs, ... }:

{
  gtk.enable = true;
  gtk.theme.package = pkgs.gnome.gnome-themes-extra;
  gtk.theme.name = "Adwaita-dark";
  gtk.iconTheme.name =
    "Tela"; # Worth trying: "Papirus-Adapta-Nokto-Maia" "Arc" "Pop"

  home.packages = [ pkgs.tela-icon-theme ];
}
