let
  bat = import ./bat.nix;
  direnv = import ./direnv.nix;
  fish = import ./fish;
  fzf = import ./fzf.nix;
  git = import ./git.nix;
  kakoune = import ./kakoune;
  ripgrep = import ./ripgrep.nix;
  starship = import ./starship.nix;
  module = { pkgs, ... }: {
    imports = [ bat direnv fish fzf git kakoune ripgrep starship ];

    programs.eza.enable = true;
    programs.btop.enable = true;

    home.packages = with pkgs; [
      bc
      entr
      fd
      jq
      neofetch
      sd
      unzip
      zip
      lazygit
      usbutils
    ];
  };
in { inherit module bat direnv fish fzf git kakoune ripgrep starship; }
