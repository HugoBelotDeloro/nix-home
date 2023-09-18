{ config, lib, pkgs, ... }:

{
  home.sessionVariables.EDITOR = "kak";

  imports = [ ./lsp ];

  programs.kakoune = {
    enable = true;

    config = {
      alignWithTabs = false;
      autoComplete = [ "insert" "prompt" ];
      autoInfo = [ "command" "onkey" ];
      autoReload = "ask";
      colorScheme = "default";
      hooks = [ ];
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
    '';
    plugins = with pkgs.kakounePlugins; [ auto-pairs-kak smarttab-kak ];
  };
}
