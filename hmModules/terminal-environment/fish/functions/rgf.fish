# Search text through files and open occurences in editor
set line (rg --color=always --line-number --no-heading $argv | \
  fzf --ansi --height=~100% --color 'hl:-1:underline,hl+:-1:underline:reverse' --delimiter ':' \
    --preview "bat --color=always {1} --highlight-line {2}" \
    --preview-window 'up,+{2}+3/3,~3'
)
set file (echo $line | cut --delimiter ':' --fields 1)
set line_number (echo $line | cut --delimiter ':' --fields 2)

if test -n "$file"
  $EDITOR $file +$line_number
end
