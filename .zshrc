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
autoload colors; colors

autoload -Uz add-zsh-hook
autoload -Uz is-at-least

# vcs_info
if is-at-least 4.3.10; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' formats       '%f(%F{cyan}%s%f:%F{green}%b%f)'
    zstyle ':vcs_info:*' actionformats '%f(%F{cyan}%s%f:%F{green}%b%f|%F{red}%a%f)'
    zstyle ':vcs_info:(svn|bzr):*' branchformat '%F{green}%b%f:%F{yellow}r%r%f'
    zstyle ":vcs_info:git:*" check-for-changes true
    zstyle ":vcs_info:git:*" stagedstr '+'
    zstyle ":vcs_info:git:*" unstagedstr '-'
    zstyle ':vcs_info:git:*' formats       '%f(%F{green}%b%f%F{green}%c%F{red}%u%f)'
    zstyle ':vcs_info:git:*' actionformats '%f(%F{green}%b%f|%F{red}%a%f%F{green}%c%F{red}%u%f)'

    function _precmd_vcs_info () {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        psvar[1]="$vcs_info_msg_0_"
    }

    add-zsh-hook precmd _precmd_vcs_info
fi

setopt prompt_subst
case "${OSTYPE}" in
darwin*)
    local PROMCOL=$'%F{$[1+RANDOM%6]}'
    PROMPT='%(?.%F{green}^-^%f.%F{red}@_@%f) '$PROMCOL'%l${WINDOW:+":$WINDOW"}:%h%F{green}$psvar[1]%f%(!.#.$) '
    ;;
*)
    case "$USER" in
    *admin)
        local PROMCOL=$'%F{1}'
        ;;
    root)
        local PROMCOL=$'%f'
        ;;
    *)
        local PROMCOL=$'%F{2}'
        ;;
    esac
    PROMPT=$PROMCOL'[${USER}@${HOST%%.*}]%f%(!.#.$) '
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

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

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
# perlbrew
[ -f ${HOME}/perl5/perlbrew/etc/bashrc ] && source ${HOME}/perl5/perlbrew/etc/bashrc

export SVN_EDITOR=/usr/bin/vim
export GIT_EDITOR=/usr/bin/vim
export PATH=$HOME/bin:/usr/local/bin:$PATH

## load user .zshrc configuration file
[ -f ${HOME}/.zshrc.local ] && source ${HOME}/.zshrc.local

## highlight for less
if [ -f /usr/local/bin/src-hilite-lesspipe.sh ]; then
     export LESS='-R'
     export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi
