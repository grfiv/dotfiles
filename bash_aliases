# for python
# ----------
#export PYTHONSTARTUP=/home/george/Dropbox/Python/python_startup.py
export PYTHONPATH=$PYTHONPATH:/home/george/Dropbox/Python

# for nvcc
# --------
#PATH=$PATH:/usr/bin

# for maven (note the release, obviously this may change)
# ---------
#PATH=$PATH:/usr/local/apache-maven/apache-maven-3.3.3/bin
#export MAVEN_OPTS="-Xms256m -Xmx512m"

# for the MNIST handwritten digits
export MNIST=/home/george/Dropbox/MNIST/data

# for hyperopt
#export OMP_NUM_THREADS=1

# ===========================================================
# load in a collection of useful functions from the dot files
# ===========================================================
DOTDIR=~/dotfiles
FUNCFILE=$DOTDIR/bash_functions.sh

if [ -d "$DOTDIR" ]; then
  if [ -f "$FUNCFILE" ]; then
    source $FUNCFILE
  else
     echo -e "\n$FUNCFILE not found\n"
  fi
else
  echo -e "\n$DOTDIR not found\n"
fi
# ===========================================================

export PATH="/usr/lib/ccache:$PATH"

# AWS cli configurations
export AWS_CONFIG_FILE=$HOME/.aws/config

# for stock ticker 'mop' command
# see http://xmodulo.com/monitor-stock-quotes-command-line-linux.html
export GOPATH=$HOME/work
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

alias ticker='mop'  # note: there is a program called ticker which you may need someday

# vim is better than vi
alias vi='vim'
export MYVIMRC=~/.vimrc

# improve the ls command to provide color and append the file type
alias ls='ls --color=auto -F'
alias ll='ls -alFh'            # make ll human readable

# reduce sensitivity of a Synaptics touchpad
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
#export PS1_ORIGINAL=$PS1
#export PS1=$(echo $PS1_ORIGINAL | sed -e 's/01;32/01;33/g')" " 

