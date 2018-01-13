DEFAULT_USER=`whoami`

export CLICOLOR=yes
export TERM=xterm-256color

source /usr/local/share/antigen/antigen.zsh
source ~/.aliases
source ~/.vim/bundle/gruvbox/gruvbox_256palette.sh

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

# antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme bhilburn/powerlevel9k powerlevel9k
# antigen use oh-my-zsh
# antigen theme refined
# antigen theme agnoster
antigen apply

update_title () {print -Pn "\e]0;%~/$(git rev-parse --is-inside-work-tree &>/dev/null && git symbolic-ref HEAD | cut -d'/' -f3)\a"}
add-zsh-hook precmd update_title
add-zsh-hook preexec update_title

