# ================================================================ #
#          Below are configurations shipped with ubuntu            #
# ================================================================ #

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Define some colors
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

# Get color based on git status
function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ ! $git_status =~ "up to date with" ]]; then
    echo -e $COLOR_BLUE
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

# Get git branch name
function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:' # username@hostname:
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\h\[\033[00m\]:' # hostname:
    PS1+='\[\033[01;34m\]\w'        # pwd
    PS1+="\[\$(git_color)\]"        # colors git status
    PS1+="\$(git_branch)"           # prints current branch
    PS1+='\[\033[00m\]\$ '          # $
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -valFh'
alias la='ls -vA'
# alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ================================================================ #
#          Below are configurations customized by user             #
# ================================================================ #

# Load local bashrc if there's any
if [ -f ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi

# Load global aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# Load local aliases
if [ -f ~/.aliases_local ]; then
  source ~/.aliases_local
fi

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it (This allows to save bash history immediately)
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Avoid duplicates in bash history
HISTCONTROL=ignoredups:erasedups

# Export the OpenCASCADE root directory
export CASROOT=$HOME/packages/OpenCASCADE
export CASARCH=
export PATH=$CASROOT/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CASROOT/lib

# Export tacs, paropt and egads directories
export TACS_DIR=$HOME/git/tacs
export PAROPT_DIR=$HOME/git/paropt
export EGADS_DIR=$HOME/git/egads4py

# Update python path
export PYTHONPATH=${PYTHONPATH}:~/git/tacs
export PYTHONPATH=${PYTHONPATH}:~/git/paropt
export PYTHONPATH=${PYTHONPATH}:~/git/tmr
export PYTHONPATH=${PYTHONPATH}:~/git/egads4py
export PYTHONPATH=${PYTHONPATH}:~/git/struct_opt_benchmarks
# export PYTHONPATH=${PYTHONPATH}:~/git/a2d
export PYTHONPATH=${PYTHONPATH}:~/toys/a2d
# export PYTHONPATH=~/Programs/ParaView/lib/python3.7/site-packages:{$PYTHONPATH}
# export PYTHONPATH=~/Programs/ParaView/lib:${PYTHONPATH}

# Updage PATH
# export PATH=~/.local/bin:$PATH
# export PATH=~/bin:$PATH

# Ipopt directories
export IPOPT_DIR=$HOME/packages/Ipopt
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$IPOPT_DIR/lib

# Use vim key binding for bash
set -o vi

# remap capslock as second esc
# setxkbmap -option caps:escape
# The previous command is not used anymore, instead,
# using dconf-editor (sudo apt install dconf-editor)
# to permanently swap esc <-> capslock,
# which can be done by the following:
# open dconf-editor, go to org/gnome/desktop/input-sources,
# in xkb-options, put 'caps:swapescape' in custom value to swap,
# or put 'caps:escape' to bind caps as another esc

# Some node.js stuff to fix an issue from pyright
export NODE\_OPTIONS=--experimental-worker

# SU2 variables
export SU2_HOME=$HOME/git/SU2
export SU2_RUN=$HOME/git/SU2/bin
export PATH=$PATH:$SU2_RUN
export PYTHONPATH=$PYTHONPATH:$SU2_RUN

# CUDA
export PATH=/usr/local/cuda-11.6/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.6/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# pyamgx
export AMGX_DIR=/home/fyc/packages/AMGX
