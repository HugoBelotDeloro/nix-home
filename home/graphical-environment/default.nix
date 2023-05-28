let
  dunst = import ./dunst.nix;
  gtk = import ./gtk.nix;
  i3 = import ./i3.nix;
  i3status = import ./i3status.nix;
  pointerCursor = import ./pointer-cursor.nix;
  rofi = import ./rofi.nix;
  screen-locker = import ./screen-locker.nix;

  module = { pkgs, ... }: {

    imports = [
      dunst
      gtk
      i3
      i3status
      pointerCursor
      rofi
      screen-locker
    ];

    fonts.fontconfig.enable = true;

    programs.autorandr.enable = true;

    xsession.enable = true;

    home.packages = with pkgs; [
      keepassxc
      pcmanfm
      firefox
    ];
  };
in {
  inherit i3 i3status pointerCursor rofi gtk module screen-locker dunst;
}
