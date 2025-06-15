# Interactive commit log
git graph --color=always \
| fzf \
  --ansi \
  --layout=reverse \
  --preview "git show --color=always (echo {} | sd '\W+([0-9a-f]+).*' '\$1')" \
  --bind 'alt-up:preview-up,alt-down:preview-down' \
  --header 'alt-(up|down) to scroll preview' \
| sd '\W+([0-9a-f]+).*' '$1'
