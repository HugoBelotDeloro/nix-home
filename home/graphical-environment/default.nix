let
  dunst = import ./dunst.nix;
  gtk = import ./gtk.nix;
  i3 = import ./i3.nix;
  i3status = import ./i3status.nix;
  kitty = import ./kitty.nix;
  pointerCursor = import ./pointer-cursor.nix;
  rofi = import ./rofi.nix;
  screen-locker = import ./screen-locker.nix;

  module = { pkgs, ... }: {

    imports = [
      dunst
      gtk
      i3
      i3status
      kitty
      pointerCursor
      rofi
      screen-locker
    ];

    fonts.fontconfig.enable = true;

    programs.autorandr.enable = true;

    xsession.enable = true;

    services.flameshot.enable = true;
    #services.pasystray.enable = true;
    services.network-manager-applet.enable = true;

    home.packages = with pkgs; [
      keepassxc
      pcmanfm
      firefox
      xsel
      pavucontrol
      gparted
      arandr
      lxappearance
    ];
  };
in {
  inherit i3 i3status pointerCursor rofi gtk module screen-locker dunst kitty;
}
