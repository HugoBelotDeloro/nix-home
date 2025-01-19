{ pkgs, ... }:
{
  home.packages = [ pkgs.editorconfig-core-c ];

  programs.kakoune.config.hooks = [
    {
      commands = "editorconfig-load";
      name = "WinCreate";
      option = "^[^*]+$";
    }
  ];
}
