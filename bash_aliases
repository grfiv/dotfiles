function addToPATH {
    #
    # add to $PATH environment variable,
    # ensuring no duplications
    #
    # usage: addToPATH ~/.local/lib/npm/bin
    #
  case ":$PATH:" in
    *":$1:"*) :;;         # already there
    *) PATH="$1:$PATH";;  # or PATH="$PATH:$1"
  esac
}


# for python
# ----------
#export PYTHONSTARTUP=/home/george/Dropbox/Python/python_startup.py
export PYTHONPATH=$PYTHONPATH:/home/george/Dropbox/Python

# for virtualenvwrapper
#     -----------------
# sudo -H pip3 install virtualenvwrapper

# location of virtual environments
export WORKON_HOME=$HOME/.virtualenvs

# default location of python development projects
export PROJECT_HOME=~/Dropbox/python_dev

source /usr/local/bin/virtualenvwrapper.sh

# I. Create a virtual environment for
#    a python project in an arbitrary /path/to/<proj-name>

# create a new virtual environment
# mkvirtualenv <proj-name>

# [optionally] create /path/to/<proj-name>
# mkdir /path/to/<proj-name>

# connect the two
# cd /path/to/<proj-name>
# setvirtualenvproject

# II. Create a virtual environment for
#     a new project in $PROJECT_HOME
# mkproject <proj-name>

#  get out of development mode
# deactivate

#  start working on the project again
# workon <name>


# for the MNIST handwritten digits
# --------------------------------
export MNIST=/home/george/Dropbox/MNIST/data

# for hyperopt
#export OMP_NUM_THREADS=1

# ===========================================================
# load in a collection of useful functions from the dot files
# ===========================================================
if [ -h .bash_functions.sh ]; then
    source .bash_functions.sh
fi
# ===========================================================

#export PATH="/usr/lib/ccache:$PATH"
addToPATH /usr/lib/ccache
export PATH

# AWS cli configurations
export AWS_CONFIG_FILE=$HOME/.aws/config

# for stock ticker 'mop' command
# see http://xmodulo.com/monitor-stock-quotes-command-line-linux.html
export GOPATH=$HOME/work
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

alias ticker='mop'  # note: there is a program called ticker which you may need someday

# improve the ls command to provide color and append the file type
# ================================================================
alias ls='ls --color=auto -F'
alias ll='ls -alFh'            # make ll human readable

# open image files from the command line with 'image xxx.png'
alias image=eog

# vim is better than vi is better than nano
# =========================================
alias vi='vim'
export MYVIMRC=~/.vimrc
export VISUAL=vi
export EDITOR="$VISUAL"

# also, enter sudo update-alternatives --config editor
# for visudo and some others

# Swap CapsLock and Esc
# =====================
/usr/bin/setxkbmap -option "caps:swapescape"
#
# For console-only servers
#
#sudo vi /etc/default/keyboard
#    XKBOPTIONS="caps:swapescape"
#sudo dpkg-reconfigure keyboard-configuration

# reduce sensitivity of a Synaptics touchpad
# ==========================================
# see https://help.ubuntu.com/community/SynapticsTouchpad
# and http://www.mepis.org/docs/en/index.php?title=Configuring_the_touchpad_with_xinput
xinput --set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Noise Cancellation" 20 20
xinput --set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Finger" 50 80 257

# Modify the color of the command prompt
# ======================================
# Black       0;30     Dark Gray     1;30
# Blue        0;34     Light Blue    1;34
# Green       0;32     Light Green   1;32
# Cyan        0;36     Light Cyan    1;36
# Red         0;31     Light Red     1;31
# Purple      0;35     Light Purple  1;35
# Brown       0;33     Yellow        1;33
# Light Gray  0;37     White         1;37

# the tput command is designed for managing terminal
# colors and other things but it is squirrelly at best
# see https://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/

# tput colors
# ===========
# 0 - Black
# 1 - Red
# 2 - Green
# 3 - Yellow
# 4 - Blue
# 5 - Magenta
# 6 - Cyan
# 7 - White

# $(tput setaf 2)             produces a light green
# $(tput bold)$(tput setaf 2) produces a bright green

export PS1_ORIGINAL=$PS1

# Bright Green
BrightGreen=$(tput bold)$(tput setaf 2)
export PS1='${debian_chroot:+($debian_chroot)}\[$BrightGreen\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Yellow
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# Red
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[00;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# Light Blue
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# For Ubuntu Desktop 16.04: yellow command prompt
#export PS1=$(echo $PS1_ORIGINAL | sed -e 's/01;32/01;33/g')" "

# For Centos 7: red command prompt
#export PS1="\e[0:31m$(echo $PS1)\e[m "

# Set terminal background to white and letters to black
# setterm -background white -foreground black -store

# Set cli terminal title to user@dir pws
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

