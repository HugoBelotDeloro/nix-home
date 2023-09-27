{ flake-inputs, ... }:

{
  nix.settings = flake-inputs.aagl.nixConfig;

  programs.anime-game-launcher.enable = true;
  programs.honkers-railway-launcher.enable = true;
}

