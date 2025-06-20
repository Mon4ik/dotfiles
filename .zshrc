# Zsh setup
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename '/home/idkncc/.zshrc'
autoload -Uz compinit
autoload -Uz vcs_info
compinit

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{#928274}%n@%m%f %~ %F{#B9BB25}${vcs_info_msg_0_}%f%B%F{#D16312}λ%f%b '

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
