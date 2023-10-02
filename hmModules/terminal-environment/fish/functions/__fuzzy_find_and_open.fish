function __fuzzy_find_and_open
  set FILENAME (fd --type f --color=always | fzf --ansi)
  if test -n "$FILENAME"
    $EDITOR $FILENAME
  end
  commandline -f repaint
end
