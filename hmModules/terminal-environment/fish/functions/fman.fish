function fman --description "Fuzzy-find a manual page"
  set page (
    man -k . \
    | fzf --query "'$argv[1]" --select-1 \
      --preview "echo {} | sd '([^(]+) \(([^)]+)\).*' '\$1.\$2' | xargs man" \
      --bind 'alt-up:preview-up,alt-down:preview-down' \
      # --bind "tab:execute(echo '{}' | sd '([^(]+) \(([^)]+)\).*' '\$1.\$2' | xargs man)" \
      --header 'alt-(up|down) to scroll preview' \
    | sd '([^(]+) \(([^)]+)\).*' '$1.$2'
  )
  if test -n "$page"
    man $page
  end
end
