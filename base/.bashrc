
# Check for an interactive session
[ -z "$PS1" ] && return

alias gita='git add'
alias gitap='git add -p'
alias gitb='git branch'
alias gitbd='git branch -d'
alias gitc='git commit'
alias gitca='git commit --amend'
alias gitco='git checkout'
alias gitcob='git checkout -b'
alias gitd='git diff'
alias gitl='git log'
alias gitm='git merge'
alias gits='git status'
alias gitsl='git shortlog'

alias ls='ls --color=auto'
tmux-nw() { echo "'$@'" | xargs tmux new-window; }
export PS1="[\u@\h:\w]\$ "

export EDITOR='vim'
