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
      # set-face global/ LineNumbersWrapped

      eval %sh{kak-lsp --kakoune -s $kak_session}
      hook global WinSetOption filetype=(typescript|javascript|rust) %{
        lsp-enable-window
      }

      lsp-inlay-hints-enable global
      map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
      map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
      map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object e '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
      map global object k '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'

      hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
      hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

      set-face global InlayHint cyan+di
    '';
    plugins = with pkgs.kakounePlugins; [ kak-lsp auto-pairs-kak ];
  };
}
