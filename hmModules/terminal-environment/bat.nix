{
  programs.bat.enable = true;

  home.sessionVariables.MANROFFOPT = "-c";
  home.sessionVariables.MANPAGER =
    "sh -c 'col -bx | bat -l man -p'";
}
