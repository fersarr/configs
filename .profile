# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
    local EXIT="$?"             # This needs to be first

    #check if theres a python venv on
    if [[ -z "${VIRTUAL_ENV}" ]]; then
        if [[ -z "${CONDA_PROMPT_MODIFIER}" ]]; then
            PS1="() "
        else
            PS1="${CONDA_PROMPT_MODIFIER}" #already includes space
        fi
    else
        PS1="($(basename ${VIRTUAL_ENV})) "
    fi

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'


    LAST2DIRS="$(basename $(dirname $PWD))/$(basename $PWD)"
    if [ $EXIT != 0 ]; then
        PS1+="${Red}\u${RCol}"      # Add red if exit code non 0
    else
        PS1+="${Gre}\u${RCol}"
    fi


    PS1+="${RCol}@${LAST2DIRS} ${BYel}$ ${RCol}"

    #tmux pane
    if tmux ls &>/dev/null; then #only if we are the same machine as current tmux session
        tmux rename-window "${LAST2DIRS}"
    fi
}

ssh() {
    box=$1
    tmux rename-window "$box" #only show box if ssh'd
    command ssh "$box"
}

#make ls colorful and show all files, including hidden
alias ll='ls -Glat'
alias tree='tree -a'
alias tree3d='tree -L 3 -d'
alias tree3='tree -L 3'
alias gitgraph='git log --all --decorate --oneline --graph'
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

set -o vi

export SHELL_SESSION_HISTORY=0  # disable per-session history so that i can see my history of shell commands
export HISTSIZE=5000
export HISTFILESIZE=5000
alias chrome='open -a "Google Chrome"'

# if i disable this then conda activate doesnt work
# set +h  # disable command hashing. interferes with python venvs

# disable debugging with =0 and use it with breakpoint()
PYTHONBREAKPOINT=pudb.set_trace
