# Zsh setup
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename '/home/idkncc/.zshrc'
autoload -Uz compinit
compinit

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

PROMPT='%n@%m %1~ %B%F{#d16312}λ%f%b '

# Environment
export GPG_TTY=$(tty)
export EDITOR="nvim"

# Aliases 
alias editdotfiles="nvim ~/.dotfiles"

function mkcd () 
{
    if [ ! -f $1 ]; then
        mkdir $1
    fi

    cd $1
}
