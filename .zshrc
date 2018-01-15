DEFAULT_USER=`whoami`

# vi mode
bindkey -v

zle -N edit-command-line
# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
autoload -Uz edit-command-line
bindkey '^f' edit-command-line
bindkey -M vicmd '^f' edit-command-line

bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward
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

source /usr/local/share/antigen/antigen.zsh
source ~/gruvbox_256palette.sh

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
    'alias'           'fg=green,bold'
    'builtin'         'fg=yellow'
    'function'        'fg=blue,bold'
    'command'         'fg=green'
    'hashed-commands' 'fg=green,underline'
    'precommand'      'fg=cyan'
    'path'            'fg=default'
)
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context vi_mode dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)
antigen theme bhilburn/powerlevel9k powerlevel9k

antigen apply

source ~/.aliases
alias -g /='cd /'
alias -g ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g ......='cd ../../../../..'

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
