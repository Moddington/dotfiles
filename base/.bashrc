
# Check for an interactive session
[ -z "$PS1" ] && return

. /usr/share/git/completion/git-completion.bash
alias gita='git add'
__git_complete gita _git_add
alias gitap='git add -p'
__git_complete gitap _git_add
alias gitb='git branch'
__git_complete gitb _git_branch
alias gitbd='git branch -d'
__git_complete gitbd _git_branch
alias gitbD='git branch -D'
__git_complete gitbD _git_branch
alias gitc='git commit'
__git_complete gitc _git_commit
alias gitca='git commit --amend'
__git_complete gitca _git_commit
alias gitco='git checkout'
__git_complete gitco _git_checkout
alias gitcob='git checkout -b'
__git_complete gitcob _git_checkout
alias gitd='git diff'
__git_complete gitd _git_diff
alias gitdc='git diff --cached'
__git_complete gitdc _git_diff
alias gitl='git log'
__git_complete gitl _git_log
alias gitm='git merge'
__git_complete gitm _git_merge
alias gits='git status'
alias gitsl='git shortlog'
__git_complete gitsl _git_shortlog

alias ls='ls --color=auto --group-directories-first'

alias dieinafire='rm -rf --'
alias perishinholyflames='sudo rm -rf --'
alias telnets='openssl s_client -quiet -connect'
tmux-nw() { echo "'$@'" | xargs tmux new-window; }
export PS1="[\u@\h:\w]\$ "

export EDITOR='vim'
#export TERM='xterm'

# mesa-vdpau (video hardware acceleration)
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=radeonsi
