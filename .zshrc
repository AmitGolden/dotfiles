# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" > /dev/null
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias ls='exa --icons --color=auto'
alias ll='ls -alhF'
alias lt='ls -hFT'
alias grep='grep --color=auto'
alias nvim=nvim_kitty
alias vim='nvim'
alias sudo='sudo '
alias checkupdates='checkupdates && paru -Qua'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lzconf='lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias j="z"
alias ji="zi"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias icat="kitty +kitten icat"

function confup {
	config commit -m "update" && config push
}

function aliasexp {
  if [[ $ZSH_VERSION ]]; then
    # shellcheck disable=2154  # aliases referenced but not assigned
    [ ${aliases[$1]+x} ] && printf '%s\n' "${aliases[$1]}" && return
  else  # bash
    [ "${BASH_ALIASES[$1]+x}" ] && printf '%s\n' "${BASH_ALIASES[$1]}" && return
  fi
  false  # Error: alias not defined
}

function gitrelease {
	MASTER=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
	git push && git checkout $MASTER && git merge develop && git push && git checkout develop
}

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Window title
precmd () {print -Pn "\033]0;${PWD}\007"}

# Settings

bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

ZVM_KEYTIMEOUT=0.1
ZVM_VI_HIGHLIGHT_BACKGROUND=white
ZVM_VI_HIGHLIGHT_FOREGROUND=black

zstyle ':fzf-tab:*' fzf-flags --height 40%
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
export LESSOPEN='|~/.lessfilter %s'

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

#local WORDCHARS='*?_[]~=&;!#$%^(){}<>'
autoload -U select-word-style
select-word-style bash

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
KEYTIMEOUT=5

# Environment variables
source ~/.profile
export SHELL=zsh

if [ "$TERM" = "linux" ]; then
  [[ ! -f ~/.p10k-tty.zsh ]] || source ~/.p10k-tty.zsh
else
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
source ~/.config/zsh/catppuccin-tty.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
zvm_after_init_commands+=('source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh && autopair-init')
eval "$(zoxide init zsh)"
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh 2>/dev/null
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
