let
  bat = import ./bat.nix;
  direnv = import ./direnv.nix;
  fish = import ./fish;
  fzf = import ./fzf.nix;
  git = import ./git.nix;
  kakoune = import ./kakoune.nix;
  starship = import ./starship.nix;
  module = { pkgs, ... }: {
    imports = [ bat direnv fish fzf git kakoune starship ];

    programs.exa.enable = true;
    programs.btop.enable = true;

    home.packages = with pkgs; [ bc entr fd jq neofetch ripgrep sd unzip zip ];
  };
in { inherit module bat direnv fish fzf git kakoune starship; }
