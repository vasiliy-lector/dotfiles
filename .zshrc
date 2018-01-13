DEFAULT_USER=`whoami`

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
source ~/.aliases
source ~/gruvbox_256palette.sh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)
antigen theme bhilburn/powerlevel9k powerlevel9k

antigen apply

# set path in terminal title
update_title () {print -Pn "\e]0;%~/$(git rev-parse --is-inside-work-tree &>/dev/null && git symbolic-ref HEAD | cut -d'/' -f3)\a"}
add-zsh-hook precmd update_title
add-zsh-hook preexec update_title
