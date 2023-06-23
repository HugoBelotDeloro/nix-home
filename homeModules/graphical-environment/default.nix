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

    imports = [ dunst gtk i3 i3status kitty pointerCursor rofi screen-locker ];

    fonts.fontconfig.enable = true;

    programs.autorandr.enable = true;

    xsession.enable = true;

    services.flameshot.enable = true;
    #services.pasystray.enable = true; one day i need to make a pr
    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;

    home.sessionVariables.BROWSER = "firefox";

    home.packages = with pkgs; [
      keepassxc
      pcmanfm
      firefox
      xclip
      xsel
      pavucontrol
      gparted
      arandr
      lxappearance
      fontpreview
    ];
  };
in {
  inherit i3 i3status pointerCursor rofi gtk module screen-locker dunst kitty;
}
