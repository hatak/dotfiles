# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload colors
colors

setopt prompt_subst
local DEFAULT=$'%{\e[0;m%}'
case "${OSTYPE}" in
darwin*)
    local PROMCOL=$'%{\e[$[31+RANDOM%6]m%}'
    PROMPT='%D{%M%S} '$PROMCOL'%l${WINDOW:+":$WINDOW"}'$DEFAULT'%(!.#.$) '
    ;;
*)
    case "$USER" in
    *admin)
        local PROMCOL=$'%{\e[$[31]m%}'
        ;;
    root)
        local PROMCOL=$DEFAULT
        ;;
    *)
        local PROMCOL=$'%{\e[$[32]m%}'
        ;;
    esac
    PROMPT=$PROMCOL'[${USER}@${HOST%%.*}]'$DEFAULT'%(!.#.$) '
    ;;
esac

RPROMPT='[%39<...<%~]'

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# select with cursor keys
#
setopt auto_menu
zstyle ':completion:*:default' menu select=1

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e
# Backspace / Delete
bindkey ""    backward-delete-char
bindkey "[3~" delete-char
# Home / End
bindkey "[1~" beginning-of-line
bindkey "[4~" end-of-line
# Page Up / Down
bindkey "[5~" beginning-of-history
bindkey "[6~" end-of-history

## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit
# auto push
setopt auto_pushd
# list packed
setopt list_packed

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -Fa"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias rm="rm -i"

alias pv="perl -le '\$m = shift; eval qq(require \$m) or die qq(module \"\$m\" is not installed \\n); print qq(\$m : ).\$m->VERSION'"

case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports() 
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

## custom functions
#
sha1() {
    shasum $1 | awk '{print $1}' > $1.sha1
}

## set env
#
export SVN_EDITOR=/usr/bin/vim
export GIT_EDITOR=/usr/bin/vim
case "${OSTYPE}" in
darwin*)
    export PATH=/opt/local/bin:$PATH
    ;;
esac

## load user .zshrc configuration file
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local

## use local lib
[ -d ${HOME}/perl5 ] && eval $(perl -I${HOME}/perl5/lib/perl5 -Mlocal::lib=${HOME}/perl5) 
