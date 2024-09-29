{
  programs.kakoune.config.hooks = [{
    group = "global";
    name = "BufSetOption";
    option = "filetype=zig";
    commands = "set buffer formatcmd 'zig fmt .'";
  }];
}
