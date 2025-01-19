{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.sessionVariables.EDITOR = "kak";

  imports = [
    ./lsp
    ./editorconfig.nix
  ];

  programs.kakoune = {
    enable = true;

    config = {
      alignWithTabs = false;
      autoComplete = [
        "insert"
        "prompt"
      ];
      autoInfo = [
        "command"
        "onkey"
      ];
      autoReload = "ask";
      colorScheme = "default";
      hooks = [
        {
          commands = "set-option global fzf_file_command fd";
          once = true;
          name = "ModuleLoaded";
          option = "fzf-file";
        }
      ];
      incrementalSearch = true;
      indentWidth = 2;
      numberLines = {
        enable = true;
        highlightCursor = true;
        relative = false;
        separator = "│";
      };
      scrollOff = {
        columns = 10;
        lines = 7;
      };
      showMatching = true;
      showWhitespace = {
        enable = true;
        lineFeed = " ";
        nonBreakingSpace = "⍽";
        space = " ";
        tab = "→";
        tabStop = "⋅";
      };
      tabStop = 2;
      ui = null;
      wrapLines = {
        enable = true;
        indent = true;
        marker = null;
        maxWidth = null;
        word = true;
      };
    };
    extraConfig = ''
      add-highlighter global/ regex \h+$ 0:Error # Highlight trailing whitespace

      set-face global InlayHint cyan+di

      enable-auto-pairs

      map global user f ': fzf-mode<ret>' -docstring "fzf commands"
    '';
    plugins = with pkgs.kakounePlugins; [
      auto-pairs-kak
      smarttab-kak
      fzf-kak
    ];
  };
}
