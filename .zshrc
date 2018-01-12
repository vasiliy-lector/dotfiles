# DEFAULT_USER=`whoami`
source ~/dotfiles/antigen.zsh
source ~/.aliases
source ~/gruvbox_256palette.sh

# antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# antigen use oh-my-zsh
antigen theme refined
# antigen theme agnoster
antigen apply

update_title () {print -Pn "\e]0;%~/$(git rev-parse --is-inside-work-tree &>/dev/null && git symbolic-ref HEAD | cut -d'/' -f3)\a"}
add-zsh-hook precmd update_title
add-zsh-hook preexec update_title

export CLICOLOR=yes
