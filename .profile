source ~/.exports
source ~/.aliases
source ~/git-completion.bash
source ~/git-prompt.sh
source ~/gruvbox_256palette.sh

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
