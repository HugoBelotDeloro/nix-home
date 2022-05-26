{ config, lib, pkgs, ... }:

{
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
        relative = true;
        separator = "|";
      };
      scrollOff = {
        columns = 10;
        lines = 7;
      };
      showMatching = true;
      showWhitespace = {
        enable = false;
        lineFeed = null;
        nonBreakingSpace = null;
        space = null;
        tab = null;
        tabStop = null;
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
    extraConfig = "add-highlighter global/ regex \\h+$ 0:Error";
    plugins = [ ];
  };
}
