# Uses fzf for switching branch
set branch (git branch | fzf | tr -d '* ')
if test -z $branch
  return
else
  git switch $branch
end
