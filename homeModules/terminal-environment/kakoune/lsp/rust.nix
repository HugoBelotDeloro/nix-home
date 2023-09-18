{
  programs.kakoune = {
    config.hooks = [
      {
        group = "global";
        name = "BufSetOption";
        option = "filetype=rust";
        commands = ''
          set buffer tabstop 4
          set buffer indentwidth 4
          set buffer formatcmd 'rustfmt'
          set buffer autowrap_column 100
          expandtab
        '';
      }
    ];
  };
}
