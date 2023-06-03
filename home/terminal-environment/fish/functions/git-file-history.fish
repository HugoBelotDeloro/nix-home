function git-file-history --description 'Browse a file\'s revisions'
  git log --oneline --follow --color=always -- $argv[1] \
  | fzf \
    --ansi \
    --layout=reverse \
    --preview "git show \
      --color=always \
      --format=format: \
      --no-prefix \
      {1} \
      -- (git rev-parse --show-toplevel)/(git log --follow --name-only --oneline {1}^..HEAD -- $argv[1] | tail -n1) \
      | tail -n +5" \
    --header 'alt-(up|down): scroll preview, alt-(left|right): show commit/file' \
    --bind 'alt-up:preview-up,alt-down:preview-down' \
    --bind "alt-right:execute@git show --color=always {1}:(git log --follow --name-only --oneline {1}^..HEAD -- $argv[1] | tail -n1) | bat --file-name $argv[1] \
      </dev/tty > /dev/tty @" \
    --bind "alt-left:execute(git show --color=always {1} | less </dev/tty > /dev/tty)" \
    | cut --delimiter ' ' --field 1
end
