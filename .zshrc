DEFAULT_USER=`whoami`

zle -N edit-command-line
# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
autoload -Uz edit-command-line
bindkey '^f' edit-command-line

export KEYTIMEOUT=1

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

setopt INTERACTIVE_COMMENTS

export CLICOLOR=yes
export TERM=xterm-256color
export LANG=ru_RU.UTF-8
export LC_ALL=ru_RU.UTF-8

# man pages colors
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[42;30m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[32m'
export LESS_TERMCAP_ue=$'\E[0m'

export PATH=./node_modules/.bin:$PATH
export PATH=~/node_modules/.bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/bin:$PATH

source /opt/homebrew/share/antigen/antigen.zsh

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
    'alias'           'fg=green,bold'
    'builtin'         'fg=yellow'
    'function'        'fg=blue,bold'
    'command'         'fg=green'
    'comment'         'fg=grey'
    'hashed-commands' 'fg=green,underline'
    'precommand'      'fg=cyan'
    'path'            'fg=default'
)
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

function git_need_upstream {
    [[ -d .git && ! $(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null) ]] && echo "⬆"
}

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_CUSTOM_NO_UPSTREAM="git_need_upstream"
POWERLEVEL9K_CUSTOM_NO_UPSTREAM_BACKGROUND="red"
POWERLEVEL9K_CUSTOM_NO_UPSTREAM_FOREGROUND="black"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv background_jobs vcs custom_no_upstream)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
antigen theme bhilburn/powerlevel9k powerlevel9k

antigen apply

source ~/.aliases
alias -g /='cd /'
alias -g ..='cd ../'
alias -g ...='cd ../../'
alias -g ....='cd ../../../'
alias -g .....='cd ../../../../'
alias -g ......='cd ../../../../../'

alias -- -='cd -'
alias ~='cd ~'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# set path in terminal title
update_title () {print -Pn "\e]0;%~/$(git rev-parse --is-inside-work-tree &>/dev/null && git symbolic-ref HEAD | cut -d'/' -f3)\a"}
add-zsh-hook precmd update_title
add-zsh-hook preexec update_title
