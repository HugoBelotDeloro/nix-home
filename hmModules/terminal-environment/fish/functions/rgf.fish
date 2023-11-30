function rgf --description "Search text through files and open occurences in editor"
  set file (rg --color=always --line-number --no-heading $argv | \
    fzf --ansi --height=~100% --color 'hl:-1:underline,hl+:-1:underline:reverse' --delimiter ':' \
      --preview "bat --color=always {1} --highlight-line {2}" \
      --preview-window 'up,+{2}+3/3,~3' | \
    cut --delimiter ':' --fields 1
  )

  if test -n "$file"
    $EDITOR $file
  end
end
