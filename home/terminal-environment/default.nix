let
  bat = import ./bat.nix;
  direnv = import ./direnv.nix;
  fzf = import ./fzf.nix;
  git = import ./git.nix;
  kakoune = import ./kakoune.nix;
  starship = import ./starship.nix;
  module = { pkgs, ... }: {
    imports = [ bat direnv fzf git kakoune starship ];

    programs.exa.enable = true;
    programs.btop.enable = true;

    home.packages = with pkgs; [
      bc
      entr
      fd
      fish
      jq
      neofetch
      ripgrep
      sd
      unzip
      zip
    ];
  };
in {
  inherit module bat direnv fzf git kakoune starship;
}
