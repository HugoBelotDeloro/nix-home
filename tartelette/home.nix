{
  config,
  lib,
  pkgs,
  flake-inputs,
  username,
  ...
}:

let
  homeDirectory = "/home/${username}";
in
{
  home = {
    inherit username homeDirectory;
    stateVersion = "21.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # See https://github.com/nix-community/home-manager/issues/2942
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  imports = with flake-inputs.self.hmModules; [ terminalEnvironment.module ];
}
