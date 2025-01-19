{
  programs.kakoune.config.hooks = [
    {
      group = "global";
      name = "BufSetOption";
      option = "filetype=rust";
      commands = "set buffer formatcmd 'rustfmt'";
    }
  ];
}
