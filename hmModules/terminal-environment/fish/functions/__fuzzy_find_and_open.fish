set FILENAME (fd --type f --color=always --no-require-git --hidden | fzf --ansi)
if test -n "$FILENAME"
  $EDITOR $FILENAME
end
commandline -f repaint
