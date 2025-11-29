let
  firefox = import ./firefox.nix;
  gtk = import ./gtk.nix;
  i3 = import ./i3.nix;
  i3status = import ./i3status.nix;
  i3status-rust = import ./i3status-rust.nix;
  kitty = import ./kitty.nix;
  plasma = import ./plasma.nix;
  pointerCursor = import ./pointer-cursor.nix;
  rofi = import ./rofi.nix;

  module =
    { pkgs, ... }:
    {

      imports = [
        firefox
        gtk
        i3
        i3status-rust
        kitty
        plasma
        pointerCursor
        rofi
      ];

      fonts.fontconfig.enable = true;

      programs.autorandr.enable = true;

      services.flameshot.enable = true;
      #services.pasystray.enable = true; one day i need to make a pr

      services.gammastep = {
        enable = true;
        tray = true;

        dawnTime = "6:00-8:00";
        duskTime = "20:00-22:00";
        provider = "manual";
        settings.general.adjustment-method = "randr";
        temperature.day = 6500;
        temperature.night = 2000;
      };

      home.packages = with pkgs; [
        keepassxc
        pcmanfm
        xclip
        xsel
        pavucontrol
        gparted
        arandr
        lxappearance
        fontpreview
        rofimoji
      ];
    };
in
{
  inherit
    firefox
    gtk
    i3
    i3status
    i3status-rust
    kitty
    module
    plasma
    pointerCursor
    rofi
    ;
}
