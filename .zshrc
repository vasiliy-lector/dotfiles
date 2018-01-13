DEFAULT_USER=`whoami`

export CLICOLOR=yes
export TERM=xterm-256color

# man pages colors
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[42;30m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[32m'
export LESS_TERMCAP_ue=$'\E[0m'

source /usr/local/share/antigen/antigen.zsh
source ~/.aliases
source ~/.vim/bundle/gruvbox/gruvbox_256palette.sh

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
