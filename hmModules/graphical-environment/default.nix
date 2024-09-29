let
  dunst = import ./dunst.nix;
  firefox = import ./firefox.nix;
  gtk = import ./gtk.nix;
  i3 = import ./i3.nix;
  i3status = import ./i3status.nix;
  kitty = import ./kitty.nix;
  pointerCursor = import ./pointer-cursor.nix;
  rofi = import ./rofi.nix;
  screen-locker = import ./screen-locker.nix;

  module = { pkgs, ... }: {

    imports =
      [ dunst firefox gtk i3 i3status kitty pointerCursor rofi screen-locker ];

    fonts.fontconfig.enable = true;

    programs.autorandr.enable = true;

    xsession.enable = true;

    services.flameshot.enable = true;
    #services.pasystray.enable = true; one day i need to make a pr
    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;

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
in {
  inherit dunst firefox gtk i3 i3status kitty module pointerCursor rofi
    screen-locker;
}
