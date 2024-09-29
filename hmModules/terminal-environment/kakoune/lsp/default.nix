{ pkgs, ... }:

{
  imports = [ ./rust.nix ];

  home.file.kak-lsp = {
    source = ./kak-lsp.toml;
    target = ".config/kak-lsp/kak-lsp.toml";
  };

  programs.kakoune = {
    config.hooks = [
      {
        group = "global";
        name = "WinSetOption";
        option = "filetype=(rust,zig)";
        commands = ''
          lsp-enable-window
        '';
      }
      {
        group = "global";
        name = "KakEnd";
        option = ".*";
        commands = "lsp-exit";
      }
    ];

    extraConfig = ''
      eval %sh{kak-lsp --kakoune -s $kak_session}

      lsp-inlay-hints-enable global
      map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
      map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
      map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object e '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
      map global object k '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
    '';

    plugins = [ pkgs.kakounePlugins.kakoune-lsp ];
  };
}
