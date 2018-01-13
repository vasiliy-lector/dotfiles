export GIT_SSL_NO_VERIFY=true
export PATH=./node_modules/.bin:$PATH
export PATH=~/node_modules/.bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/bin:$PATH

export NODE_PATH=./node_modules:$NODE_PATH

export LANG=ru_RU.UTF-8

# git prompt settings
function parse_git_dirty {
  [[ $(git diff --name-only 2> /dev/null) ]] && echo "✹"
}
function parse_git_dirty_staged {
  [[ $(git diff --staged --name-only 2> /dev/null) ]] && echo "✚"
}
function parse_git_dirty_untracked {
  [[ $(git ls-files --others --exclude-standard  2> /dev/null) ]] && echo "✭"
}
function parse_git_unpushed {
  [[ $(git log --branches --not --remotes  2> /dev/null) ]] && echo "⬆"
}
function get_git_info {
    b=$(__git_ps1 "%s")
    d=$(parse_git_dirty)$(parse_git_dirty_staged)$(parse_git_dirty_untracked)$(parse_git_unpushed)
    [[ $b && $d ]] && i="$b $d" || i=$b
    [[ $i ]] && echo "  $i "
}
export PS1='\[\033[45m\]\[\033[30m\] \w \[\033[35m\]\[\033[44m\]\[\033[30m\]$(get_git_info)\[\033[0m\]\[\033[34m\]\[\033[0m\] '
PROMPT_TITLE='echo -ne "\033]0;${PWD/#$HOME/~}/$(__git_ps1 "%s/")\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE};"

export LC_ALL=ru_RU.UTF-8
export EDITOR=vim
export PAGER=less
export CLICOLOR=yes; # git colors
export TERM=xterm-256color

export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[42;30m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[32m'
export LESS_TERMCAP_ue=$'\E[0m'

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# fix sorting against underscores
export LC_COLLATE=C

source ~/.aliases
source ~/git-completion.bash
source ~/git-prompt.sh
source ~/gruvbox_256palette.sh

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
