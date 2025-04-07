{
  programs.kakoune.config.hooks = [
    {
      group = "global";
      name = "BufSetOption";
      option = "filetype=python";
      commands = "set buffer formatcmd 'ruff format'";
    }
  ];
}
