function fman --description "Fuzzy-find a manual page"
  set page (man -k . | fzf -q "'$argv[1]" --select-1 | sd '([^(]+) \(([^)]+)\).*' '$1.$2')
  if test -n "$page"
    man $page
  end
end
